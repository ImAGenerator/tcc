/* The copyright in this software is being made available under the BSD
 * License, included below. This software may be subject to other third party
 * and contributor rights, including patent rights, and no such rights are
 * granted under this license.
 *
 * Copyright (c) 2010-2018, ITU/ISO/IEC
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *  * Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *  * Neither the name of the ITU/ISO/IEC nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */

/** \file     Prediction.cpp
    \brief    prediction class
*/

#include "InterPrediction.h"

#include "Buffer.h"
#include "UnitTools.h"

#include <memory.h>
#include <algorithm>

//! \ingroup CommonLib
//! \{

// ====================================================================================================================
// Constructor / destructor / initialize
// ====================================================================================================================

InterPrediction::InterPrediction()
:
  m_currChromaFormat( NUM_CHROMA_FORMAT )
, m_maxCompIDToPred ( MAX_NUM_COMPONENT )
, m_pcRdCost        ( nullptr )
#if JVET_L0265_AFF_MINIMUM4X4
, m_storedMv        ( nullptr )
#endif
{
  for( uint32_t ch = 0; ch < MAX_NUM_COMPONENT; ch++ )
  {
    for( uint32_t refList = 0; refList < NUM_REF_PIC_LIST_01; refList++ )
    {
      m_acYuvPred[refList][ch] = nullptr;
    }
  }

  for( uint32_t c = 0; c < MAX_NUM_COMPONENT; c++ )
  {
    for( uint32_t i = 0; i < LUMA_INTERPOLATION_FILTER_SUB_SAMPLE_POSITIONS; i++ )
    {
      for( uint32_t j = 0; j < LUMA_INTERPOLATION_FILTER_SUB_SAMPLE_POSITIONS; j++ )
      {
        m_filteredBlock[i][j][c] = nullptr;
      }

      m_filteredBlockTmp[i][c] = nullptr;
    }
  }

}

InterPrediction::~InterPrediction()
{
  destroy();
}

void InterPrediction::destroy()
{
  for( uint32_t i = 0; i < NUM_REF_PIC_LIST_01; i++ )
  {
    for( uint32_t c = 0; c < MAX_NUM_COMPONENT; c++ )
    {
      xFree( m_acYuvPred[i][c] );
      m_acYuvPred[i][c] = nullptr;
    }
  }

  for( uint32_t c = 0; c < MAX_NUM_COMPONENT; c++ )
  {
    for( uint32_t i = 0; i < LUMA_INTERPOLATION_FILTER_SUB_SAMPLE_POSITIONS; i++ )
    {
      for( uint32_t j = 0; j < LUMA_INTERPOLATION_FILTER_SUB_SAMPLE_POSITIONS; j++ )
      {
        xFree( m_filteredBlock[i][j][c] );
        m_filteredBlock[i][j][c] = nullptr;
      }

      xFree( m_filteredBlockTmp[i][c] );
      m_filteredBlockTmp[i][c] = nullptr;
    }
  }

#if JVET_L0265_AFF_MINIMUM4X4
  if (m_storedMv != nullptr)
  {
    delete[]m_storedMv;
  }
#endif
}

void InterPrediction::init( RdCost* pcRdCost, ChromaFormat chromaFormatIDC )
{
  m_pcRdCost = pcRdCost;


  // if it has been initialised before, but the chroma format has changed, release the memory and start again.
  if( m_acYuvPred[REF_PIC_LIST_0][COMPONENT_Y] != nullptr && m_currChromaFormat != chromaFormatIDC )
  {
    destroy();
  }

  m_currChromaFormat = chromaFormatIDC;
  if( m_acYuvPred[REF_PIC_LIST_0][COMPONENT_Y] == nullptr ) // check if first is null (in which case, nothing initialised yet)
  {
    for( uint32_t c = 0; c < MAX_NUM_COMPONENT; c++ )
    {
      int extWidth  = MAX_CU_SIZE + 16;
      int extHeight = MAX_CU_SIZE + 1;
      for( uint32_t i = 0; i < LUMA_INTERPOLATION_FILTER_SUB_SAMPLE_POSITIONS; i++ )
      {
        m_filteredBlockTmp[i][c] = ( Pel* ) xMalloc( Pel, ( extWidth + 4 ) * ( extHeight + 7 + 4 ) );

        for( uint32_t j = 0; j < LUMA_INTERPOLATION_FILTER_SUB_SAMPLE_POSITIONS; j++ )
        {
          m_filteredBlock[i][j][c] = ( Pel* ) xMalloc( Pel, extWidth * extHeight );
        }
      }

      // new structure
      for( uint32_t i = 0; i < NUM_REF_PIC_LIST_01; i++ )
      {
        m_acYuvPred[i][c] = ( Pel* ) xMalloc( Pel, MAX_CU_SIZE * MAX_CU_SIZE );
      }
    }


    m_iRefListIdx = -1;
    
  }

#if !JVET_J0090_MEMORY_BANDWITH_MEASURE
  m_if.initInterpolationFilter( true );
#endif

#if JVET_L0265_AFF_MINIMUM4X4
  const int MVBUFFER_SIZE = MAX_CU_SIZE / MIN_PU_SIZE;
  m_storedMv = new Mv [MVBUFFER_SIZE*MVBUFFER_SIZE];
#endif
}

bool checkIdenticalMotion( const PredictionUnit &pu, bool checkAffine )
{
  const Slice &slice = *pu.cs->slice;

  if( slice.isInterB() && !pu.cs->pps->getWPBiPred() )
  {
    if( pu.refIdx[0] >= 0 && pu.refIdx[1] >= 0 )
    {
      int RefPOCL0 = slice.getRefPic( REF_PIC_LIST_0, pu.refIdx[0] )->getPOC();
      int RefPOCL1 = slice.getRefPic( REF_PIC_LIST_1, pu.refIdx[1] )->getPOC();

      if( RefPOCL0 == RefPOCL1 )
      {
        if( !pu.cu->affine )
        {
          if( pu.mv[0] == pu.mv[1] )
          {
            return true;
          }
        }
        else
        {
          CHECK( !checkAffine, "In this case, checkAffine should be on." );
          const CMotionBuf &mb = pu.getMotionBuf();
          if ( (pu.cu->affineType == AFFINEMODEL_4PARAM && (mb.at( 0, 0 ).mv[0] == mb.at( 0, 0 ).mv[1]) && (mb.at( mb.width - 1, 0 ).mv[0] == mb.at( mb.width - 1, 0 ).mv[1]))
            || (pu.cu->affineType == AFFINEMODEL_6PARAM && (mb.at( 0, 0 ).mv[0] == mb.at( 0, 0 ).mv[1]) && (mb.at( mb.width - 1, 0 ).mv[0] == mb.at( mb.width - 1, 0 ).mv[1]) && (mb.at( 0, mb.height - 1 ).mv[0] == mb.at( 0, mb.height - 1 ).mv[1])) )
          {
            return true;
          }
        }
      }
    }
  }

  return false;
}

// ====================================================================================================================
// Public member functions
// ====================================================================================================================

bool InterPrediction::xCheckIdenticalMotion( const PredictionUnit &pu )
{
  const Slice &slice = *pu.cs->slice;

  if( slice.isInterB() && !pu.cs->pps->getWPBiPred() )
  {
    if( pu.refIdx[0] >= 0 && pu.refIdx[1] >= 0 )
    {
      int RefPOCL0 = slice.getRefPic( REF_PIC_LIST_0, pu.refIdx[0] )->getPOC();
      int RefPOCL1 = slice.getRefPic( REF_PIC_LIST_1, pu.refIdx[1] )->getPOC();

      if( RefPOCL0 == RefPOCL1 )
      {
        if( !pu.cu->affine )
        {
          if( pu.mv[0] == pu.mv[1] )
          {
            return true;
          }
        }
        else
        {
          const CMotionBuf &mb = pu.getMotionBuf();
          if ( (pu.cu->affineType == AFFINEMODEL_4PARAM && (mb.at( 0, 0 ).mv[0] == mb.at( 0, 0 ).mv[1]) && (mb.at( mb.width - 1, 0 ).mv[0] == mb.at( mb.width - 1, 0 ).mv[1]))
            || (pu.cu->affineType == AFFINEMODEL_6PARAM && (mb.at( 0, 0 ).mv[0] == mb.at( 0, 0 ).mv[1]) && (mb.at( mb.width - 1, 0 ).mv[0] == mb.at( mb.width - 1, 0 ).mv[1]) && (mb.at( 0, mb.height - 1 ).mv[0] == mb.at( 0, mb.height - 1 ).mv[1])) )
          {
            return true;
          }
        }
      }
    }
  }

  return false;
}

void InterPrediction::xSubPuMC( PredictionUnit& pu, PelUnitBuf& predBuf, const RefPicList &eRefPicList /*= REF_PIC_LIST_X*/ )
{

  // compute the location of the current PU
  Position puPos    = pu.lumaPos();
  Size puSize       = pu.lumaSize();

  int numPartLine, numPartCol, puHeight, puWidth;
  {
    const Slice& slice = *pu.cs->slice;
    numPartLine = std::max(puSize.width >> slice.getSubPuMvpSubblkLog2Size(), 1u);
    numPartCol  = std::max(puSize.height >> slice.getSubPuMvpSubblkLog2Size(), 1u);
    puHeight    = numPartCol == 1 ? puSize.height : 1 << slice.getSubPuMvpSubblkLog2Size();
    puWidth     = numPartLine == 1 ? puSize.width : 1 << slice.getSubPuMvpSubblkLog2Size();
  }

  PredictionUnit subPu;

  subPu.cs        = pu.cs;
  subPu.cu        = pu.cu;
  subPu.mergeType = MRG_TYPE_DEFAULT_N;

  // join sub-pus containing the same motion
  bool verMC = puSize.height > puSize.width;
  int  fstStart = (!verMC ? puPos.y : puPos.x);
  int  secStart = (!verMC ? puPos.x : puPos.y);
  int  fstEnd = (!verMC ? puPos.y + puSize.height : puPos.x + puSize.width);
  int  secEnd = (!verMC ? puPos.x + puSize.width : puPos.y + puSize.height);
  int  fstStep = (!verMC ? puHeight : puWidth);
  int  secStep = (!verMC ? puWidth : puHeight);

  for (int fstDim = fstStart; fstDim < fstEnd; fstDim += fstStep)
  {
    for (int secDim = secStart; secDim < secEnd; secDim += secStep)
    {
      int x = !verMC ? secDim : fstDim;
      int y = !verMC ? fstDim : secDim;
      const MotionInfo &curMi = pu.getMotionInfo(Position{ x, y });

      int length = secStep;
      int later  = secDim + secStep;

      while (later < secEnd)
      {
        const MotionInfo &laterMi = !verMC ? pu.getMotionInfo(Position{ later, fstDim }) : pu.getMotionInfo(Position{ fstDim, later });
        if (laterMi == curMi)
        {
          length += secStep;
        }
        else
        {
          break;
        }
        later += secStep;
      }
      int dx = !verMC ? length : puWidth;
      int dy = !verMC ? puHeight : length;

      subPu.UnitArea::operator=(UnitArea(pu.chromaFormat, Area(x, y, dx, dy)));
      subPu = curMi;
      PelUnitBuf subPredBuf = predBuf.subBuf(UnitAreaRelative(pu, subPu));

      motionCompensation(subPu, subPredBuf, eRefPicList);
      secDim = later - secStep;
    }
  }
}


void InterPrediction::xPredInterUni(const PredictionUnit& pu, const RefPicList& eRefPicList, PelUnitBuf& pcYuvPred, const bool& bi 
)
{
  const SPS &sps = *pu.cs->sps;

  int iRefIdx = pu.refIdx[eRefPicList];
  Mv mv[3];

  if( pu.cu->affine )
  {
    CHECK( iRefIdx < 0, "iRefIdx incorrect." );

    const CMotionBuf &mb = pu.getMotionBuf();
    mv[0] = mb.at( 0,            0             ).mv[eRefPicList];
    mv[1] = mb.at( mb.width - 1, 0             ).mv[eRefPicList];
    mv[2] = mb.at( 0,            mb.height - 1 ).mv[eRefPicList];
  }
  else
  {
    mv[0] = pu.mv[eRefPicList];
  }
  if ( !pu.cu->affine )
  clipMv(mv[0], pu.cu->lumaPos(), sps);


  for( uint32_t comp = COMPONENT_Y; comp < pcYuvPred.bufs.size() && comp <= m_maxCompIDToPred; comp++ )
  {
    const ComponentID compID = ComponentID( comp );
    if ( pu.cu->affine )
    {
      xPredAffineBlk( compID, pu, pu.cu->slice->getRefPic( eRefPicList, iRefIdx ), mv, pcYuvPred, bi, pu.cu->slice->clpRng( compID ) );
    }
    else
    {
      xPredInterBlk( compID, pu, pu.cu->slice->getRefPic( eRefPicList, iRefIdx ), mv[0], pcYuvPred, bi, pu.cu->slice->clpRng( compID )
                    );
    }
  }
}

void InterPrediction::xPredInterBi(PredictionUnit& pu, PelUnitBuf &pcYuvPred)
{
  const PPS   &pps   = *pu.cs->pps;
  const Slice &slice = *pu.cs->slice;


  for (uint32_t refList = 0; refList < NUM_REF_PIC_LIST_01; refList++)
  {
    if( pu.refIdx[refList] < 0)
    {
      continue;
    }

    RefPicList eRefPicList = (refList ? REF_PIC_LIST_1 : REF_PIC_LIST_0);

    CHECK( pu.refIdx[refList] >= slice.getNumRefIdx( eRefPicList ), "Invalid reference index" );
    m_iRefListIdx = refList;

    PelUnitBuf pcMbBuf = ( pu.chromaFormat == CHROMA_400 ?
                           PelUnitBuf(pu.chromaFormat, PelBuf(m_acYuvPred[refList][0], pcYuvPred.Y())) :
                           PelUnitBuf(pu.chromaFormat, PelBuf(m_acYuvPred[refList][0], pcYuvPred.Y()), PelBuf(m_acYuvPred[refList][1], pcYuvPred.Cb()), PelBuf(m_acYuvPred[refList][2], pcYuvPred.Cr())) );

    if (pu.refIdx[0] >= 0 && pu.refIdx[1] >= 0)
    {
      xPredInterUni ( pu, eRefPicList, pcMbBuf, true
                     );
    }
    else
    {
      if( ( (pps.getUseWP() && slice.getSliceType() == P_SLICE) || (pps.getWPBiPred() && slice.getSliceType() == B_SLICE) ) )
      {
        xPredInterUni ( pu, eRefPicList, pcMbBuf, true );
      }
      else
      {
        xPredInterUni ( pu, eRefPicList, pcMbBuf, false );
      }
    }
  }


  CPelUnitBuf srcPred0 = ( pu.chromaFormat == CHROMA_400 ?
                           CPelUnitBuf(pu.chromaFormat, PelBuf(m_acYuvPred[0][0], pcYuvPred.Y())) :
                           CPelUnitBuf(pu.chromaFormat, PelBuf(m_acYuvPred[0][0], pcYuvPred.Y()), PelBuf(m_acYuvPred[0][1], pcYuvPred.Cb()), PelBuf(m_acYuvPred[0][2], pcYuvPred.Cr())) );
  CPelUnitBuf srcPred1 = ( pu.chromaFormat == CHROMA_400 ?
                           CPelUnitBuf(pu.chromaFormat, PelBuf(m_acYuvPred[1][0], pcYuvPred.Y())) :
                           CPelUnitBuf(pu.chromaFormat, PelBuf(m_acYuvPred[1][0], pcYuvPred.Y()), PelBuf(m_acYuvPred[1][1], pcYuvPred.Cb()), PelBuf(m_acYuvPred[1][2], pcYuvPred.Cr())) );
  if( pps.getWPBiPred() && slice.getSliceType() == B_SLICE )
  {
    xWeightedPredictionBi( pu, srcPred0, srcPred1, pcYuvPred, m_maxCompIDToPred );
  }
  else if( pps.getUseWP() && slice.getSliceType() == P_SLICE )
  {
    xWeightedPredictionUni( pu, srcPred0, REF_PIC_LIST_0, pcYuvPred, -1, m_maxCompIDToPred );
  }
  else
  {
    xWeightedAverage( pu, srcPred0, srcPred1, pcYuvPred, slice.getSPS()->getBitDepths(), slice.clpRngs() );
  }
}


void InterPrediction::xPredInterBlk ( const ComponentID& compID, const PredictionUnit& pu, const Picture* refPic, const Mv& _mv, PelUnitBuf& dstPic, const bool& bi, const ClpRng& clpRng
                                    )
{
  JVET_J0090_SET_REF_PICTURE( refPic, compID );
  const ChromaFormat  chFmt = pu.chromaFormat;
  const bool          rndRes = !bi;

  int iAddPrecShift = 0;

#if !REMOVE_MV_ADAPT_PREC
  if (_mv.highPrec)
  {
    CHECKD(!pu.cs->sps->getSpsNext().getUseHighPrecMv(), "Found a high-precision motion vector, but the high-precision MV extension is disabled!");
#endif
    iAddPrecShift = VCEG_AZ07_MV_ADD_PRECISION_BIT_FOR_STORE;
#if !REMOVE_MV_ADAPT_PREC
  }
#endif

  int shiftHor = 2 + iAddPrecShift + ::getComponentScaleX(compID, chFmt);
  int shiftVer = 2 + iAddPrecShift + ::getComponentScaleY(compID, chFmt);

  int xFrac = _mv.hor & ((1 << shiftHor) - 1);
  int yFrac = _mv.ver & ((1 << shiftVer) - 1);

  xFrac <<= VCEG_AZ07_MV_ADD_PRECISION_BIT_FOR_STORE - iAddPrecShift;
  yFrac <<= VCEG_AZ07_MV_ADD_PRECISION_BIT_FOR_STORE - iAddPrecShift;
#if !REMOVE_MV_ADAPT_PREC
  CHECKD(!pu.cs->sps->getSpsNext().getUseHighPrecMv() && ((xFrac & 3) != 0), "Invalid fraction");
  CHECKD(!pu.cs->sps->getSpsNext().getUseHighPrecMv() && ((yFrac & 3) != 0), "Invalid fraction");
#endif

  PelBuf &dstBuf  = dstPic.bufs[compID];
  unsigned width  = dstBuf.width;
  unsigned height = dstBuf.height;

  CPelBuf refBuf;
  {
    Position offset = pu.blocks[compID].pos().offset( _mv.getHor() >> shiftHor, _mv.getVer() >> shiftVer );
    refBuf = refPic->getRecoBuf( CompArea( compID, chFmt, offset, pu.blocks[compID].size() ) );
  }

  if( yFrac == 0 )
  {
    m_if.filterHor(compID, (Pel*) refBuf.buf, refBuf.stride, dstBuf.buf, dstBuf.stride, width, height, xFrac, rndRes, chFmt, clpRng);
  }
  else if( xFrac == 0 )
  {
    m_if.filterVer(compID, (Pel*) refBuf.buf, refBuf.stride, dstBuf.buf, dstBuf.stride, width, height, yFrac, true, rndRes, chFmt, clpRng);
  }
  else
  {
      PelBuf tmpBuf = PelBuf(m_filteredBlockTmp[0][compID], pu.blocks[compID]);

    int vFilterSize = isLuma(compID) ? NTAPS_LUMA : NTAPS_CHROMA;
    m_if.filterHor(compID, (Pel*) refBuf.buf - ((vFilterSize >> 1) - 1) * refBuf.stride, refBuf.stride, tmpBuf.buf, tmpBuf.stride, width, height + vFilterSize - 1, xFrac, false,         chFmt, clpRng);
    JVET_J0090_SET_CACHE_ENABLE( false );
    m_if.filterVer(compID, (Pel*) tmpBuf.buf + ((vFilterSize >> 1) - 1) * tmpBuf.stride, tmpBuf.stride, dstBuf.buf, dstBuf.stride, width, height,                   yFrac, false, rndRes, chFmt, clpRng);
    JVET_J0090_SET_CACHE_ENABLE( true );
  }
}

void InterPrediction::xPredAffineBlk( const ComponentID& compID, const PredictionUnit& pu, const Picture* refPic, const Mv* _mv, PelUnitBuf& dstPic, const bool& bi, const ClpRng& clpRng )
{
  if ( (pu.cu->affineType == AFFINEMODEL_6PARAM && _mv[0] == _mv[1] && _mv[0] == _mv[2])
    || (pu.cu->affineType == AFFINEMODEL_4PARAM && _mv[0] == _mv[1])
    )
  {
    Mv mvTemp = _mv[0];
    clipMv( mvTemp, pu.cu->lumaPos(), *pu.cs->sps );
    xPredInterBlk( compID, pu, refPic, mvTemp, dstPic, bi, clpRng );
    return;
  }

  JVET_J0090_SET_REF_PICTURE( refPic, compID );
  const ChromaFormat chFmt = pu.chromaFormat;
  int iScaleX = ::getComponentScaleX( compID, chFmt );
  int iScaleY = ::getComponentScaleY( compID, chFmt );

  Mv mvLT =_mv[0];
  Mv mvRT =_mv[1];
  Mv mvLB =_mv[2];

#if !REMOVE_MV_ADAPT_PREC
  mvLT.setHighPrec();
  mvRT.setHighPrec();
  mvLB.setHighPrec();
#endif

  // get affine sub-block width and height
  const int width  = pu.Y().width;
  const int height = pu.Y().height;
  int blockWidth = AFFINE_MIN_BLOCK_SIZE;
  int blockHeight = AFFINE_MIN_BLOCK_SIZE;

  blockWidth  >>= iScaleX;
  blockHeight >>= iScaleY;

 #if JVET_L0265_AFF_MINIMUM4X4
  blockWidth =  std::max(blockWidth, AFFINE_MIN_BLOCK_SIZE);
  blockHeight = std::max(blockHeight, AFFINE_MIN_BLOCK_SIZE);

  CHECK(blockWidth  > (width >> iScaleX ), "Sub Block width  > Block width");
  CHECK(blockHeight > (height >> iScaleX), "Sub Block height > Block height");
  const int MVBUFFER_SIZE = MAX_CU_SIZE / MIN_PU_SIZE;
#endif

  const int cxWidth  = width  >> iScaleX;
  const int cxHeight = height >> iScaleY;
  const int iHalfBW  = blockWidth  >> 1;
  const int iHalfBH  = blockHeight >> 1;

  const int iBit = MAX_CU_DEPTH;
  int iDMvHorX, iDMvHorY, iDMvVerX, iDMvVerY;
  iDMvHorX = (mvRT - mvLT).getHor() << (iBit - g_aucLog2[cxWidth]);
  iDMvHorY = (mvRT - mvLT).getVer() << (iBit - g_aucLog2[cxWidth]);
  if ( pu.cu->affineType == AFFINEMODEL_6PARAM )
  {
    iDMvVerX = (mvLB - mvLT).getHor() << (iBit - g_aucLog2[cxHeight]);
    iDMvVerY = (mvLB - mvLT).getVer() << (iBit - g_aucLog2[cxHeight]);
  }
  else
  {
    iDMvVerX = -iDMvHorY;
    iDMvVerY = iDMvHorX;
  }

  int iMvScaleHor = mvLT.getHor() << iBit;
  int iMvScaleVer = mvLT.getVer() << iBit;
  const SPS &sps    = *pu.cs->sps;
  const int iMvShift = 4;
  const int iOffset  = 8;
  const int iHorMax = ( sps.getPicWidthInLumaSamples()     + iOffset -      pu.Y().x - 1 ) << iMvShift;
  const int iHorMin = (      -(int)pu.cs->pcv->maxCUWidth  - iOffset - (int)pu.Y().x + 1 ) << iMvShift;
  const int iVerMax = ( sps.getPicHeightInLumaSamples()    + iOffset -      pu.Y().y - 1 ) << iMvShift;
  const int iVerMin = (      -(int)pu.cs->pcv->maxCUHeight - iOffset - (int)pu.Y().y + 1 ) << iMvShift;

  PelBuf tmpBuf = PelBuf(m_filteredBlockTmp[0][compID], pu.blocks[compID]);
  const int vFilterSize = isLuma(compID) ? NTAPS_LUMA : NTAPS_CHROMA;

  const int shift = iBit - 4 + VCEG_AZ07_MV_ADD_PRECISION_BIT_FOR_STORE + 2;

  // get prediction block by block
  for ( int h = 0; h < cxHeight; h += blockHeight )
  {
    for ( int w = 0; w < cxWidth; w += blockWidth )
    {

#if JVET_L0265_AFF_MINIMUM4X4
       int iMvScaleTmpHor, iMvScaleTmpVer;
       if(compID == COMPONENT_Y)
       {
           iMvScaleTmpHor = iMvScaleHor + iDMvHorX * (iHalfBW + w) + iDMvVerX * (iHalfBH + h);
           iMvScaleTmpVer = iMvScaleVer + iDMvHorY * (iHalfBW + w) + iDMvVerY * (iHalfBH + h);
           roundAffineMv(iMvScaleTmpHor, iMvScaleTmpVer, shift);

           // clip and scale
           iMvScaleTmpHor = std::min<int>(iHorMax, std::max<int>(iHorMin, iMvScaleTmpHor));
           iMvScaleTmpVer = std::min<int>(iVerMax, std::max<int>(iVerMin, iMvScaleTmpVer));

           m_storedMv[h / AFFINE_MIN_BLOCK_SIZE * MVBUFFER_SIZE + w / AFFINE_MIN_BLOCK_SIZE].set(iMvScaleTmpHor, iMvScaleTmpVer);
       }
       else
       {
          Mv curMv = (m_storedMv[((h << iScaleY) / AFFINE_MIN_BLOCK_SIZE) * MVBUFFER_SIZE + ((w << iScaleX) / AFFINE_MIN_BLOCK_SIZE)] +
            m_storedMv[((h << iScaleY) / AFFINE_MIN_BLOCK_SIZE + 1)* MVBUFFER_SIZE + ((w << iScaleX) / AFFINE_MIN_BLOCK_SIZE)] +
            m_storedMv[((h << iScaleY) / AFFINE_MIN_BLOCK_SIZE)* MVBUFFER_SIZE + ((w << iScaleX) / AFFINE_MIN_BLOCK_SIZE + 1)] +
            m_storedMv[((h << iScaleY) / AFFINE_MIN_BLOCK_SIZE + 1)* MVBUFFER_SIZE + ((w << iScaleX) / AFFINE_MIN_BLOCK_SIZE + 1)] +
            Mv(2, 2));
          curMv.set(curMv.getHor() >> 2, curMv.getVer() >> 2);     
          iMvScaleTmpHor = curMv.hor;
          iMvScaleTmpVer = curMv.ver;
       }
#else
      int iMvScaleTmpHor = iMvScaleHor + iDMvHorX * (iHalfBW + w) + iDMvVerX * (iHalfBH + h);
      int iMvScaleTmpVer = iMvScaleVer + iDMvHorY * (iHalfBW + w) + iDMvVerY * (iHalfBH + h);
      roundAffineMv( iMvScaleTmpHor, iMvScaleTmpVer, shift );

      // clip and scale
      iMvScaleTmpHor = std::min<int>( iHorMax, std::max<int>( iHorMin, iMvScaleTmpHor ) );
      iMvScaleTmpVer = std::min<int>( iVerMax, std::max<int>( iVerMin, iMvScaleTmpVer ) );
#endif
      // get the MV in high precision
      int xFrac, yFrac, xInt, yInt;

      if (!iScaleX)
      {
        xInt  = iMvScaleTmpHor >> 4;
        xFrac = iMvScaleTmpHor & 15;
      }
      else
      {
        xInt  = iMvScaleTmpHor >> 5;
        xFrac = iMvScaleTmpHor & 31;
      }
      if (!iScaleY)
      {
        yInt  = iMvScaleTmpVer >> 4;
        yFrac = iMvScaleTmpVer & 15;
      }
      else
      {
        yInt  = iMvScaleTmpVer >> 5;
        yFrac = iMvScaleTmpVer & 31;
      }

      const CPelBuf refBuf = refPic->getRecoBuf( CompArea( compID, chFmt, pu.blocks[compID].offset(xInt + w, yInt + h), pu.blocks[compID] ) );
      PelBuf &dstBuf = dstPic.bufs[compID];

      if ( yFrac == 0 )
      {
        m_if.filterHor( compID, (Pel*) refBuf.buf, refBuf.stride, dstBuf.buf + w + h * dstBuf.stride, dstBuf.stride, blockWidth, blockHeight, xFrac, !bi, chFmt, clpRng );
      }
      else if ( xFrac == 0 )
      {
        m_if.filterVer( compID, (Pel*) refBuf.buf, refBuf.stride, dstBuf.buf + w + h * dstBuf.stride, dstBuf.stride, blockWidth, blockHeight, yFrac, true, !bi, chFmt, clpRng );
      }
      else
      {
        m_if.filterHor( compID, (Pel*) refBuf.buf - ((vFilterSize>>1) -1)*refBuf.stride, refBuf.stride, tmpBuf.buf, tmpBuf.stride, blockWidth, blockHeight+vFilterSize-1, xFrac, false,      chFmt, clpRng);
        JVET_J0090_SET_CACHE_ENABLE( false );
        m_if.filterVer( compID, tmpBuf.buf + ((vFilterSize>>1) -1)*tmpBuf.stride, tmpBuf.stride, dstBuf.buf + w + h * dstBuf.stride, dstBuf.stride, blockWidth, blockHeight, yFrac, false, !bi, chFmt, clpRng);
        JVET_J0090_SET_CACHE_ENABLE( true );
      }
    }
  }
}

int getMSB( unsigned x )
{
  int msb = 0, bits = ( sizeof(int) << 3 ), y = 1;
  while( x > 1u )
  {
    bits >>= 1;
    y      = x >> bits;
    if( y )
    {
      x    = y;
      msb += bits;
    }
  }
  msb += y;
  return msb;
}


void InterPrediction::xWeightedAverage( const PredictionUnit& pu, const CPelUnitBuf& pcYuvSrc0, const CPelUnitBuf& pcYuvSrc1, PelUnitBuf& pcYuvDst, const BitDepths& clipBitDepths, const ClpRngs& clpRngs )
{
  const int iRefIdx0 = pu.refIdx[0];
  const int iRefIdx1 = pu.refIdx[1];

  if( iRefIdx0 >= 0 && iRefIdx1 >= 0 )
  {
#if JVET_L0646_GBI
    if( pu.cu->GBiIdx != GBI_DEFAULT )
    {
      pcYuvDst.addWeightedAvg(pcYuvSrc0, pcYuvSrc1, clpRngs, pu.cu->GBiIdx);
      return;
    }
#endif
    pcYuvDst.addAvg( pcYuvSrc0, pcYuvSrc1, clpRngs );
  }
  else if( iRefIdx0 >= 0 && iRefIdx1 < 0 )
  {
    pcYuvDst.copyClip( pcYuvSrc0, clpRngs );
  }
  else if( iRefIdx0 < 0 && iRefIdx1 >= 0 )
  {
    pcYuvDst.copyClip( pcYuvSrc1, clpRngs );
  }
}

void InterPrediction::motionCompensation( PredictionUnit &pu, PelUnitBuf &predBuf, const RefPicList &eRefPicList 
)
{
        CodingStructure &cs = *pu.cs;
  const PPS &pps            = *cs.pps;
  const SliceType sliceType =  cs.slice->getSliceType();

  if( eRefPicList != REF_PIC_LIST_X )
  {
    if( ( ( sliceType == P_SLICE && pps.getUseWP() ) || ( sliceType == B_SLICE && pps.getWPBiPred() ) ) )
    {
      xPredInterUni         ( pu,          eRefPicList, predBuf, true );
      xWeightedPredictionUni( pu, predBuf, eRefPicList, predBuf, -1, m_maxCompIDToPred );
    }
    else
    {
      xPredInterUni( pu, eRefPicList, predBuf, false );
    }
  }
  else
  {
    if( pu.mergeType != MRG_TYPE_DEFAULT_N )
    {
      xSubPuMC( pu, predBuf, eRefPicList );
    }
    else if( xCheckIdenticalMotion( pu ) )
    {
      xPredInterUni( pu, REF_PIC_LIST_0, predBuf, false );
    }
    else
    {
      xPredInterBi( pu, predBuf );
    }
  }
  return;
}

void InterPrediction::motionCompensation( CodingUnit &cu, const RefPicList &eRefPicList 
)
{
  for( auto &pu : CU::traversePUs( cu ) )
  {
    PelUnitBuf predBuf = cu.cs->getPredBuf( pu );
    motionCompensation( pu, predBuf, eRefPicList );
  }
}

void InterPrediction::motionCompensation( PredictionUnit &pu, const RefPicList &eRefPicList /*= REF_PIC_LIST_X*/ 
)
{
  PelUnitBuf predBuf = pu.cs->getPredBuf( pu );
  motionCompensation( pu, predBuf, eRefPicList 
  );
}




#if JVET_J0090_MEMORY_BANDWITH_MEASURE
void InterPrediction::cacheAssign( CacheModel *cache )
{
  m_cacheModel = cache;
  m_if.cacheAssign( cache );
  m_if.initInterpolationFilter( !cache->isCacheEnable() );
}
#endif

//! \}
