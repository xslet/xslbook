<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="if">
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A generated ID of a base node. -->
  <xsl:param name="data_gid"/>
  <!--** Elements which are allowed to be applied. -->
  <xsl:param name="allow"/>
  <!--** A flag if test node is allowed. -->
  <xsl:param name="allow_text_node"/>
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
    <xsl:with-param name="name">of</xsl:with-param>
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="data_gid" select="$_data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_is_matched">
   <xsl:choose>
    <xsl:when test="string-length($_path) != 0">
     <xsl:variable name="_content">
      <xsl:call-template name="do:first_object_by_path">
       <xsl:with-param name="path" select="$_path"/>
       <xsl:with-param name="what">content</xsl:with-param>
       <xsl:with-param name="data_url" select="$_data_url"/>
       <xsl:with-param name="data_gid" select="$_data_gid"/>
      </xsl:call-template>
     </xsl:variable>
     <xsl:call-template name="bk:_match_condition_by_operators">
      <xsl:with-param name="value" select="$_content"/>
      <xsl:with-param name="data_url" select="$_data_url"/>
      <xsl:with-param name="data_gir" select="$_data_gid"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:variable name="_test">
      <xsl:call-template name="bk:get_attribute">
       <xsl:with-param name="name">test</xsl:with-param>
       <xsl:with-param name="data_url" select="$_data_url"/>
       <xsl:with-param name="data_gid" select="$_data_gid"/>
      </xsl:call-template>
     </xsl:variable>
     <xsl:call-template name="do:match_condition_by_path">
      <xsl:with-param name="condition" select="$_test"/>
      <xsl:with-param name="data_url" select="$_data_url"/>
      <xsl:with-param name="data_gid" select="$_data_gid"/>
     </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="$_is_matched = $ut:true">
    <xsl:call-template name="do:for_times">
     <xsl:with-param name="times" select="1"/>
     <xsl:with-param name="data_url" select="$_data_url"/>
     <xsl:with-param name="data_gid" select="$_data_gid"/>
     <xsl:with-param name="allow" select="$allow"/>
     <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
     <xsl:with-param name="deny">|attr|else|</xsl:with-param>
     <xsl:with-param name="arg0" select="$arg0"/>
     <xsl:with-param name="arg1" select="$arg1"/>
     <xsl:with-param name="arg2" select="$arg2"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="else">
     <xsl:call-template name="do:for_times">
      <xsl:with-param name="times" select="1"/>
      <xsl:with-param name="data_url" select="$_data_url"/>
      <xsl:with-param name="data_gid" select="$_data_gid"/>
      <xsl:with-param name="allow" select="$allow"/>
      <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
      <xsl:with-param name="deny">|attr|else|</xsl:with-param>
      <xsl:with-param name="arg0" select="$arg0"/>
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
     </xsl:call-template>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="bk:_match_condition_by_operators">
  <xsl:param name="value"/>
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:variable name="_eq">
   <xsl:call-template name="bk:get_attribute">
    <xsl:with-param name="name">eq</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_ne">
   <xsl:call-template name="bk:get_attribute">
    <xsl:with-param name="name">ne</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_le">
   <xsl:call-template name="bk:get_attribute">
    <xsl:with-param name="name">le</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_lt">
   <xsl:call-template name="bk:get_attribute">
    <xsl:with-param name="name">lt</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_ge">
   <xsl:call-template name="bk:get_attribute">
    <xsl:with-param name="name">ge</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_gt">
   <xsl:call-template name="bk:get_attribute">
    <xsl:with-param name="name">gt</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_is_not_matched">
   <xsl:if test="string-length($_eq) != 0 and not($value = $_eq)">1</xsl:if>
   <xsl:if test="string-length($_ne) != 0 and not($value != $_ne)">1</xsl:if>
   <xsl:if test="string-length($_le) != 0 and not($value &lt;= $_le)">1</xsl:if>
   <xsl:if test="string-length($_lt) != 0 and not($value &lt; $_lt)">1</xsl:if>
   <xsl:if test="string-length($_ge) != 0 and not($value &gt;= $_ge)">1</xsl:if>
   <xsl:if test="string-length($_gt) != 0 and not($value &gt; $_gt)">1</xsl:if>
  </xsl:variable>
  <xsl:if test="string-length($_is_not_matched) = 0">
   <xsl:value-of select="$ut:true"/>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
