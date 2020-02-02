<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Gets an attribute value if it exists, 
 -->
 <xsl:template name="bk:get_attribute">
  <xsl:param name="name"/>
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
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
  <xsl:choose>
   <xsl:when test="@*[name()=$name]">
    <xsl:value-of select="@*[name()=$name]"/>
   </xsl:when>
   <xsl:when test="boolean(attr[@name=$name])">
    <xsl:apply-templates select="attr[@name=$name]">
     <xsl:with-param name="data_url" select="$_data_url"/>
     <xsl:with-param name="data_gid" select="$_data_gid"/>
     <xsl:with-param name="arg0" select="$arg0"/>
     <xsl:with-param name="arg1" select="$arg1"/>
     <xsl:with-param name="arg2" select="$arg2"/>
    </xsl:apply-templates>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
