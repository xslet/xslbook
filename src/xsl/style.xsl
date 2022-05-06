<?xml version="1.0" encoding="utf-8"?>                                          
<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template name="book:use_css">
  <xsl:param name="data_url"/>
  <link rel="stylesheet" href="{$book:xsl_dir}/xslbook.css" type="text/css"/>
  <xsl:apply-templates select="style" mode="xslbook">
   <xsl:with-param name="data_url" select="$data_url"/>
  </xsl:apply-templates>
 </xsl:template>

 <xsl:template match="style" mode="xslbook">
  <xsl:param name="data_url"/>
  <xsl:variable name="_href">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">href</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <link rel="stylesheet" href="{$_href}" type="text/css"/>
 </xsl:template>

</xsl:stylesheet>
