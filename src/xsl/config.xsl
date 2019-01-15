<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:param name="bk:preface_index_format"></xsl:param>
 <xsl:param name="bk:chapter_index_format">1.</xsl:param>
 <xsl:param name="bk:appendix_index_format">A.</xsl:param>
 <xsl:param name="bk:postface_index_format"></xsl:param>
 <xsl:param name="bk:clause_index_format">1.</xsl:param>
 <xsl:param name="bk:section_index_format">1.</xsl:param>

 <xsl:param name="bk:default_toc_target">
  <xsl:text>|preface|chapter|appendix|postface|clause|</xsl:text>
 </xsl:param>
 <xsl:param name="bk:default_toc_title">Table of contents</xsl:param>
 <xsl:param name="bk:default_navi_prev">previous</xsl:param>
 <xsl:param name="bk:default_navi_next">next</xsl:param>
 <xsl:param name="bk:default_navi_toc">table of contents</xsl:param>

</xsl:stylesheet>
