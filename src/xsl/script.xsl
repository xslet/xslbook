<?xml version="1.0" encoding="utf-8"?>                                          
<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template name="book:use_js">
  <xsl:param name="data_url"/>
  <script src="{$book:xsl_dir}/xslbook.js" type="text/javascript"></script>
  <xsl:apply-templates select="script" mode="xslbook">
   <xsl:with-param name="data_url" select="$data_url"/>
  </xsl:apply-templates>
 </xsl:template>

 <xsl:template match="script" mode="xslbook">
  <xsl:param name="data_url"/>
  <xsl:variable name="_href">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">href</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <script src="{$_href}" type="text/javascript"></script>
 </xsl:template>

</xsl:stylesheet>
