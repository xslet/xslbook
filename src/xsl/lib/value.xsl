<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


 <!--**
  This template gets a value of an element at the specified path. The path is specified with `of` attribute. The prefix and suffix for a value can be specified with `prefix` and `suffix` attributes.
 -->
 <xsl:template match="value">
  <!--** An URL of data source file from an ancestor element. -->
  <xsl:param name="data_url" />
  <!--** A generated ID of a current node in a data source file. -->
  <xsl:param name="data_gid" />
  <xsl:variable name="_data_url">
   <xsl:call-template name="book:get_data_url">
    <xsl:with-param name="data_url" select="$data_url" />
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_data_gid">
   <xsl:call-template name="book:get_data_gid">
    <xsl:with-param name="data_gid" select="$data_gid" />
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_path">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">of</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url" />
    <xsl:with-param name="data_gid" select="$data_gid" />
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_prefix">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">prefix</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url" />
    <xsl:with-param name="data_gid" select="$data_gid" />
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_suffix">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">suffix</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url" />
    <xsl:with-param name="data_gid" select="$data_gid" />
   </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="do:first_object_by_path">
   <xsl:with-param name="path" select="$_path" />
   <xsl:with-param name="what">text</xsl:with-param>
   <xsl:with-param name="data_url" select="$_data_url" />
   <xsl:with-param name="data_gid" select="$_data_gid" />
   <xsl:with-param name="prefix" select="$_prefix" />
   <xsl:with-param name="suffix" select="$_suffix" />
  </xsl:call-template>
 </xsl:template>


</xsl:stylesheet>
