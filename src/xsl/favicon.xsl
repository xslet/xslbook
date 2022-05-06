<?xml version="1.0" encoding="utf-8"?>                                          
<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template name="book:use_favicon">
  <xsl:param name="data_url"/>
  <xsl:apply-templates select="favicon[1]" mode="xslbook">
   <xsl:with-param name="data_url" select="$data_url"/>
  </xsl:apply-templates>
 </xsl:template>

 <xsl:template match="favicon" mode="xslbook">
  <xsl:param name="data_url"/>
  <xsl:variable name="_href">
   <xsl:call-template name="book:get_attr">
    <xsl:with-param name="name">href</xsl:with-param>
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_len" select="string-length($_href)"/>
  <xsl:if test="$_len != 0">
   <xsl:variable name="_type">
    <xsl:variable name="_ext3" select="substring($_href, $_len - 3)"/>
    <xsl:variable name="_ext4" select="substring($_href, $_len - 4)"/>
    <xsl:choose>
     <xsl:when test="$_ext3 = '.ico'">image/vnd.microsoft.icon</xsl:when>
     <xsl:when test="$_ext3 = '.png'">image/png</xsl:when>
     <xsl:when test="$_ext3 = '.svg'">image/svg+xml</xsl:when>
     <xsl:when test="$_ext3 = '.gif'">image/gif</xsl:when>
     <xsl:when test="$_ext3 = '.jpg'">image/jpeg</xsl:when>
     <xsl:when test="$_ext4 = '.jpeg'">image/jpeg</xsl:when>
    </xsl:choose>
   </xsl:variable>
   <link rel="icon" href="{$_href}" type="{$_type}"/>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
