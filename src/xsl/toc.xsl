<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/sttk/xslet/2019/xslutil"
 xmlns:bk="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:param name="bk:toc_url">
  <xsl:choose>
   <xsl:when test="contains(/xslbook/@toc, '#')">
    <xsl:value-of select="substring-before(/xslbook/@toc, '#')"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="/xslbook/@toc"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:param>

 <xsl:template name="bk:write_navi_header">
 </xsl:template>

 <xsl:template name="bk:write_navi_footer">
 </xsl:template>

</xsl:stylesheet>
