<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/sttk/xslet/2019/xslutil"
 xmlns:bk="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="p|br|b|i|u">
  <xsl:param name="data_url"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:element name="{name()}">
   <xsl:for-each select="attribute::*">
    <xsl:attribute name="name()">
     <xsl:value-of select="."/>
    </xsl:attribute>
   </xsl:for-each>
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>

</xsl:stylesheet>
