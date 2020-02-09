<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Get an URL of a data source by `data-src` attribute or a parameter from an ancestor element.
 -->
 <xsl:template name="bk:get_data_url">
  <!--** An URL of external data file from an ancestor element. -->
  <xsl:param name="data_url"/>
  <xsl:choose>
   <xsl:when test="boolean(@data-src)">
    <xsl:value-of select="@data-src"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$data_url"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!--**
   Get a generated ID of an element in an data source file.
   If `data-src` attribute is presented, this returns an empty string.
 -->
 <xsl:template name="bk:get_data_gid">
  <!--** A generated ID of a base node from an ancestor element. -->
  <xsl:param name="data_gid"/>
  <xsl:if test="not(boolean(@data-src))">
   <xsl:value-of select="$data_gid"/>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
