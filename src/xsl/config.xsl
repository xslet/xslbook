<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:param name="book:preface_index_format"></xsl:param>
 <xsl:param name="book:chapter_index_format">1.</xsl:param>
 <xsl:param name="book:appendix_index_format">A.</xsl:param>
 <xsl:param name="book:postface_index_format"></xsl:param>
 <xsl:param name="book:clause_index_format">1.</xsl:param>
 <xsl:param name="book:section_index_format">1.</xsl:param>

 <xsl:param name="book:default_toc_target">
  <xsl:text>|preface|chapter|appendix|postface|clause|</xsl:text>
 </xsl:param>
 <xsl:param name="book:default_toc_title">Table of contents</xsl:param>
 <xsl:param name="book:default_navi_prev">previous</xsl:param>
 <xsl:param name="book:default_navi_next">next</xsl:param>
 <xsl:param name="book:default_navi_toc">table of contents</xsl:param>

 <xsl:param name="book:label_of_nolink">(No link)</xsl:param>
 <xsl:param name="book:popup_of_nolink">
  <xsl:text>There is no linked element</xsl:text>
 </xsl:param>

</xsl:stylesheet>
