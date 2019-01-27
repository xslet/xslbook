<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:util="https://github.com/sttk/xslet/2019/util"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template name="util:get_dir_from_url">
  <xsl:param name="url"/>
  <xsl:choose>
   <xsl:when test="not(contains($url, '/'))">.</xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="util:_get_dir_from_url_r">
     <xsl:with-param name="url" select="$url"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="util:_get_dir_from_url_r">
  <xsl:param name="url"/>
  <xsl:value-of select="substring-before($url, '/')"/>
  <xsl:variable name="suburl" select="substring-after($url, '/')"/>
  <xsl:if test="string-length($suburl) &gt; 0">
   <xsl:variable name="subdir">
    <xsl:call-template name="util:_get_dir_from_url_r">
     <xsl:with-param name="url" select="$suburl"/>
    </xsl:call-template>
   </xsl:variable>
   <xsl:if test="string-length($subdir) &gt; 0">
    <xsl:value-of select="concat('/', $subdir)"/>
   </xsl:if>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
