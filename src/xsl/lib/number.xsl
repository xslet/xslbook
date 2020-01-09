<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Get a number value of an element at the specified path which contains values of descendant elements.
   The path is specified with `of` attribute.
   The prefix and suffix can be specified with `prefix` and `suffix` attributes.
 -->
 <xsl:template match="number">
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generate-id of a base node. -->
  <xsl:param name="data_gid"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_data_gid">
   <xsl:call-template name="bk:get_data_gid">
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="do:first_object_by_path">
   <xsl:with-param name="path" select="@of"/>
   <xsl:with-param name="what">number</xsl:with-param>
   <xsl:with-param name="data_url" select="$_data_url"/>
   <xsl:with-param name="data_gid" select="$_data_gid"/>
   <xsl:with-param name="prefix" select="@prefix"/>
   <xsl:with-param name="suffix" select="@suffix"/>
  </xsl:call-template>
 </xsl:template>

</xsl:stylesheet>
