/*
	This file is part of Warzone 2100.
	Copyright (C) 1999-2004  Eidos Interactive
	Copyright (C) 2005-2013  Warzone 2100 Project

	Warzone 2100 is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Warzone 2100 is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Warzone 2100; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
*/
/***************************************************************************/
/*
 * ivisdef.h
 *
 * type defines for all ivis library functions.
 *
 */
/***************************************************************************/

#ifndef _ivisdef_h
#define _ivisdef_h

#include "lib/framework/frame.h"
#include "lib/framework/opengl.h"
#include "pietypes.h"

#include <vector>
#include <QtCore/QVector>
#include <string>


//*************************************************************************
//
// screen surface structure
//
//*************************************************************************
struct iClip
{
	int32_t left, top, right, bottom;
};

struct iSurface
{
	int xcentre;
	int ycentre;
	iClip clip;

	int width;
	int height;
};

//*************************************************************************
//
// imd structures
//
//*************************************************************************

/// Stores the from and to verticles from an edge
struct EDGE
{
	int from, to;
};

struct iIMDPoly
{
	uint32_t flags;
	int32_t zcentre;
	Vector3f normal;
	int pindex[3];
	Vector2f *texCoord;
	Vector2f texAnim;
};

enum VBO_TYPE
{
	VBO_VERTEX,
	VBO_TEXCOORD,
	VBO_MINIMAL,
	VBO_NORMAL = VBO_MINIMAL,
	VBO_INDEX,
	VBO_COUNT
};

struct iIMDShape
{
	iIMDShape();

	unsigned int flags;	
	int texpage;
	int tcmaskpage;
	int normalpage;
	int sradius, radius;
	Vector3i min, max;

	Vector3f ocen;
	unsigned short numFrames;
	unsigned short animInterval;

	unsigned int nconnectors;
	Vector3i *connectors;

	unsigned int nShadowEdges;
	EDGE *shadowEdgeList;
	float material[LIGHT_MAX][4];
	float shininess;

	// The old rendering data
	unsigned int npoints;
	Vector3f *points;
	unsigned int npolys;
	iIMDPoly *polys;

	// The new rendering data
	GLuint buffers[VBO_COUNT];

	iIMDShape *next;  // next pie in multilevel pies (NULL for non multilevel !)
};


//*************************************************************************
//
// immitmap image structures
//
//*************************************************************************

struct ImageDef
{
	unsigned int TPageID;   /**< Which associated file to read our info from */
	unsigned int Tu;        /**< First vertex coordinate */
	unsigned int Tv;        /**< Second vertex coordinate */
	unsigned int Width;     /**< Width of image */
	unsigned int Height;    /**< Height of image */
	int XOffset;            /**< X offset into source position */
	int YOffset;            /**< Y offset into source position */
};

struct Image;

struct IMAGEFILE
{
	struct Page
	{
		int id;    /// OpenGL texture ID.
		int size;  /// Size of texture in pixels. (Should be square.)
	};

	Image find(std::string const &name);  // Defined in bitimage.cpp.

	std::vector<Page> pages;          /// Texture pages.
	std::vector<ImageDef> imageDefs;  /// Stored images.
	std::vector<std::pair<std::string, int> > imageNames;  ///< Names of images, sorted by name. Can lookup indices from name.
};

struct Image
{
	Image(IMAGEFILE const *images = NULL, unsigned id = 0) : images(const_cast<IMAGEFILE *>(images)), id(id) {}

	int width() const { return images->imageDefs[id].Width; }
	int height() const { return images->imageDefs[id].Height; }
	int xOffset() const { return images->imageDefs[id].XOffset; }
	int yOffset() const { return images->imageDefs[id].YOffset; }

	IMAGEFILE *images;
	unsigned id;
};

#endif // _ivisdef_h
