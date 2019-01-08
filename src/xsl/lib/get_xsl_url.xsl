<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/sttk/xslet/2019/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template name="ut:get_xsl_url">
  <xsl:param name="pi" select="/processing-instruction('xml-stylesheet')"/>
  <xsl:variable name="QUOT">"</xsl:variable>
  <xsl:variable name="APOS">'</xsl:variable>
  <xsl:variable name="s1" select="substring-after($pi, 'href')"/>
  <xsl:if test="normalize-space(substring-before($s1, '=')) = ''">
   <xsl:variable name="s2" select="substring-after($s1, '=')"/>
   <xsl:choose>
    <xsl:when test="substring($s2, 1, 1) = $QUOT">
     <xsl:value-of select="translate(substring-before(substring-after($s2, $QUOT), $QUOT), '\', '/')"/>
    </xsl:when>
    <xsl:when test="substring($s2, 1, 1) = $APOS">
     <xsl:value-of select="translate(substring-before(substring-after($s2, $APOS), $APOS), '\', '/')"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:variable name="s3" select="normalize-space($s2)"/>
     <xsl:choose>
      <xsl:when test="substring($s3, 1, 1) = $QUOT">
       <xsl:value-of select="translate(substring-before(substring-after($s2, $QUOT), $QUOT), '\', '/')"/>
      </xsl:when>
      <xsl:when test="substring($s3, 1, 1) = $APOS">
       <xsl:value-of select="translate(substring-before(substring-after($s2, $APOS), $APOS), '\', '/')"/>
      </xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
