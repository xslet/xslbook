<?xml version="1.0" encoding="utf-8"?>
  
<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Loops for each node at a specified path or specified times.
   The path is specfied with `each` attribute.
   The times is specified with `times` attribute.
 -->
 <xsl:template match="for">
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generate-id of a base node. -->
  <xsl:param name="data_gid"/>
  <!--** Elements which are allowed to be applied. -->
  <xsl:param name="allow"/>
  <!--** A flag if test node is allowed. -->
  <xsl:param name="allow_text_node"/>
  <!--** Elements which are denied to be applied. -->
  <xsl:param name="deny"/>
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
  <xsl:variable name="_path">
   <xsl:call-template name="bk:get_attribute">
    <xsl:with-param name="name">each</xsl:with-param>
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="data_gid" select="$_data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_times">
   <xsl:call-template name="bk:get_attribute">
    <xsl:with-param name="name">times</xsl:with-param>
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="data_gid" select="$_data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($_times) != 0">
    <xsl:call-template name="do:for_times">
     <xsl:with-param name="times" select="$_times"/>
     <xsl:with-param name="data_url" select="$_data_url"/>
     <xsl:with-param name="data_gid" select="$_data_gid"/>
     <xsl:with-param name="allow" select="$allow"/>
     <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
     <xsl:with-param name="deny" select="'|attr|'"/>
     <xsl:with-param name="arg0" select="$arg0"/>
     <xsl:with-param name="arg1" select="$arg1"/>
     <xsl:with-param name="arg2" select="$arg2"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="do:for_by_path">
     <xsl:with-param name="path" select="$_path"/>
     <xsl:with-param name="data_url" select="$_data_url"/>
     <xsl:with-param name="data_gid" select="$_data_gid"/>
     <xsl:with-param name="allow" select="$allow"/>
     <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
     <xsl:with-param name="deny" select="'|attr|'"/>
     <xsl:with-param name="arg0" select="$arg0"/>
     <xsl:with-param name="arg1" select="$arg1"/>
     <xsl:with-param name="arg2" select="$arg2"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
