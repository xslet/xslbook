<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


 <!--**
  This named template gets an URL of data source file by `data-src` attribute or a parameter `data_url` from an ancestor element.
  The value by `data-src` attribute takes precedence over the value by the parameter.
 -->
 <xsl:template name="book:get_data_url">
  <!--** An URL of data source file from an ancestor element. -->
  <xsl:param name="data_url" />
  <!--** A generated ID of a current node in a data source file. -->
  <xsl:param name="data_gid" />
  <xsl:choose>
   <xsl:when test="boolean(@data-src)">
    <xsl:value-of select="@data-src" />
   </xsl:when>
   <xsl:when test="boolean(attr[@name='data-src'])">
    <xsl:apply-templates select="attr[@name='data-src']">
     <xsl:with-param name="data_url" select="$data_url" />
     <xsl:with-param name="data_gid" select="$data_gid" />
    </xsl:apply-templates>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$data_url" />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
