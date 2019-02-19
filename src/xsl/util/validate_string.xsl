<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:util="https://github.com/sttk/xslet/2019/util"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template name="util:validate_string">
  <xsl:param name="value"/>
  <xsl:param name="forbidden"/>
  <xsl:param name="default"/>
  <xsl:variable name="_s" select="translate($value, $forbidden, '')"/>
  <xsl:choose>
   <xsl:when test="string-length($_s) = string-length($value)">
    <xsl:value-of select="$value"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$default"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
