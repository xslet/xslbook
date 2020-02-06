<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="choose">
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:param name="allow"/>
  <xsl:param name="allow_text_node"/>
  <xsl:param name="arg0"/>
  <xsl:param name="arg1"/>
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
  <xsl:variable name="_when_count" select="count(when)"/>
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
    <xsl:call-template name="bk:_match_condition_in_when_by_operators_rcr">
     <xsl:with-param name="value" select="$_content"/>
     <xsl:with-param name="when_index">1</xsl:with-param>
     <xsl:with-param name="when_count" select="$_when_count"/>
     <xsl:with-param name="data_url" select="$_data_url"/>
     <xsl:with-param name="data_gid" select="$_data_gid"/>
     <xsl:with-param name="allow" select="$allow"/>
     <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
     <xsl:with-param name="deny">|attr|</xsl:with-param>
     <xsl:with-param name="arg0" select="$arg0"/>
     <xsl:with-param name="arg1" select="$arg1"/>
     <xsl:with-param name="arg2" select="$arg2"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="bk:_match_condition_in_when_by_test_rcr">
     <xsl:with-param name="when_index">1</xsl:with-param>
     <xsl:with-param name="when_count" select="$_when_count"/>
     <xsl:with-param name="data_url" select="$_data_url"/>
     <xsl:with-param name="data_gid" select="$_data_gid"/>
     <xsl:with-param name="allow" select="$allow"/>
     <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
     <xsl:with-param name="deny">|attr|</xsl:with-param>
     <xsl:with-param name="arg0" select="$arg0"/>
     <xsl:with-param name="arg1" select="$arg1"/>
     <xsl:with-param name="arg2" select="$arg2"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="bk:_match_condition_in_when_by_operators_rcr">
  <xsl:param name="value"/>
  <xsl:param name="when_index"/>
  <xsl:param name="when_count"/>
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:param name="allow"/>
  <xsl:param name="allow_text_node"/>
  <xsl:param name="deny"/>
  <xsl:param name="arg0"/>
  <xsl:param name="arg1"/>
  <xsl:param name="arg2"/>
  <xsl:choose>
   <xsl:when test="$when_index &lt;= $when_count">
    <xsl:for-each select="when[position() = $when_index]">
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
     <xsl:variable name="_is_matched">
      <xsl:call-template name="bk:_match_condition_by_operators">
       <xsl:with-param name="value" select="$value"/>
       <xsl:with-param name="data_url" select="$_data_url"/>
       <xsl:with-param name="data_gid" select="$_data_gid"/>
      </xsl:call-template>
     </xsl:variable>
     <xsl:choose>
      <xsl:when test="$_is_matched = $ut:true">
       <xsl:call-template name="do:for_times">
        <xsl:with-param name="times" select="1"/>
        <xsl:with-param name="data_url" select="$_data_url"/>
        <xsl:with-param name="data_gid" select="$_data_gid"/>
        <xsl:with-param name="allow" select="$allow"/>
        <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
        <xsl:with-param name="deny">|attr|</xsl:with-param>
        <xsl:with-param name="arg0" select="$arg0"/>
        <xsl:with-param name="arg1" select="$arg1"/>
        <xsl:with-param name="arg2" select="$arg2"/>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <xsl:for-each select="..">
        <xsl:call-template name="bk:_match_condition_in_when_by_operators_rcr">
         <xsl:with-param name="value" select="$value"/>
         <xsl:with-param name="when_index" select="$when_index + 1"/>
         <xsl:with-param name="when_count" select="$when_count"/>
         <xsl:with-param name="data_url" select="$_data_url"/>
         <xsl:with-param name="data_gid" select="$_data_gid"/>
         <xsl:with-param name="allow" select="$allow"/>
         <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
         <xsl:with-param name="deny">|attr|</xsl:with-param>
         <xsl:with-param name="arg0" select="$arg0"/>
         <xsl:with-param name="arg1" select="$arg1"/>
         <xsl:with-param name="arg2" select="$arg2"/>
        </xsl:call-template>
       </xsl:for-each>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="otherwise">
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
     <xsl:call-template name="do:for_times">
      <xsl:with-param name="times" select="1"/>
      <xsl:with-param name="data_url" select="$_data_url"/>
      <xsl:with-param name="data_gid" select="$_data_gid"/>
      <xsl:with-param name="allow" select="$allow"/>
      <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
      <xsl:with-param name="deny">|attr|</xsl:with-param>
      <xsl:with-param name="arg0" select="$arg0"/>
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
     </xsl:call-template>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="bk:_match_condition_in_when_by_test_rcr">
  <xsl:param name="when_index"/>
  <xsl:param name="when_count"/>
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:param name="allow"/>
  <xsl:param name="allow_text_node"/>
  <xsl:param name="deny"/>
  <xsl:param name="arg0"/>
  <xsl:param name="arg1"/>
  <xsl:param name="arg2"/>
  <xsl:choose>
   <xsl:when test="$when_index &lt;= $when_count">
    <xsl:for-each select="when[position() = $when_index]">
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
     <xsl:variable name="_is_matched">
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
     </xsl:variable>
     <xsl:choose>
      <xsl:when test="$_is_matched = $ut:true">
       <xsl:call-template name="do:for_times">
        <xsl:with-param name="times" select="1"/>
        <xsl:with-param name="data_url" select="$_data_url"/>
        <xsl:with-param name="data_gid" select="$_data_gid"/>
        <xsl:with-param name="allow" select="$allow"/>
        <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
        <xsl:with-param name="deny">|attr|</xsl:with-param>
        <xsl:with-param name="arg0" select="$arg0"/>
        <xsl:with-param name="arg1" select="$arg1"/>
        <xsl:with-param name="arg2" select="$arg2"/>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <xsl:for-each select="..">
        <xsl:call-template name="bk:_match_condition_in_when_by_test_rcr">
         <xsl:with-param name="when_index" select="$when_index + 1"/>
         <xsl:with-param name="when_count" select="$when_count"/>
         <xsl:with-param name="data_url" select="$data_url"/>
         <xsl:with-param name="data_gid" select="$data_gid"/>
         <xsl:with-param name="allow" select="$allow"/>
         <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
         <xsl:with-param name="deny">|attr|</xsl:with-param>
         <xsl:with-param name="arg0" select="$arg0"/>
         <xsl:with-param name="arg1" select="$arg1"/>
         <xsl:with-param name="arg2" select="$arg2"/>
        </xsl:call-template>
       </xsl:for-each>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="otherwise">
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
     <xsl:call-template name="do:for_times">
      <xsl:with-param name="times" select="1"/>
      <xsl:with-param name="data_url" select="$_data_url"/>
      <xsl:with-param name="data_gid" select="$_data_gid"/>
      <xsl:with-param name="allow" select="$allow"/>
      <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
      <xsl:with-param name="deny">|attr|</xsl:with-param>
      <xsl:with-param name="arg0" select="$arg0"/>
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
     </xsl:call-template>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
