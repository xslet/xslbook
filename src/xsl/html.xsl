<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
  Prints a HTML element.
 -->
 <xsl:template match="p|br|hr|b|i|u|s|code|sup|sub|q">
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generated-id of a base node. -->
  <xsl:param name="data_gid"/>
  <!--** A flag if text node is allowed. -->
  <xsl:param name="allow_text_node" select="$ut:true"/>
  <!--** Elements which are denied to be applied. -->
  <xsl:param name="deny">|attr|</xsl:param>
  <!--** Any argument 0. -->
  <xsl:param name="arg0"/>
  <!--** Any argument 1. -->
  <xsl:param name="arg1"/>
  <!--** Any argument 2. -->
  <xsl:param name="arg2"/>
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
  <xsl:element name="{name()}">
   <xsl:for-each select="attribute::*">
    <xsl:attribute name="{name()}">
     <xsl:value-of select="."/>
    </xsl:attribute>
   </xsl:for-each>
   <xsl:for-each select="attr">
    <xsl:attribute name="{@name}">
     <xsl:apply-templates>
      <xsl:with-param name="data_url" select="$_data_url"/>
      <xsl:with-param name="data_gid" select="$_data_gid"/>
     </xsl:apply-templates>
    </xsl:attribute>
   </xsl:for-each>
   <xsl:apply-templates select="node()[name()!='attr']">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="data_gid" select="$_data_gid"/>
   </xsl:apply-templates>
  </xsl:element>
 </xsl:template>

</xsl:stylesheet>
