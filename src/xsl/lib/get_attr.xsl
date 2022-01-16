<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
  This named template gets an attribute value or a content value of `attr` element which has same name with the attribute.
  The attribute value takes precedence over the `attr` element value.
 -->
 <xsl:template name="book:get_attr">
  <!--** The attribute name. -->
  <xsl:param name="name" />
  <!--** An URL of data source file from an ancestor element. -->
  <xsl:param name="data_url" />
  <!--** A generated ID of a current node in a data source file. -->
  <xsl:param name="data_gid" />
  <!--** An argument which is passed through xsldo modules. -->
  <xsl:param name="arg0" />
  <!--** An argument which is passed through xsldo modules. -->
  <xsl:param name="arg1" />
  <!--** An argument which is passed through xsldo modules. -->
  <xsl:param name="arg2" />
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
  <xsl:choose>
   <xsl:when test="@*[name()=$name]">
    <xsl:value-of select="@*[name()=$name]" />
   </xsl:when>
   <xsl:otherwise>
    <xsl:for-each select="attr[@name=$name]">
     <xsl:apply-templates>
      <xsl:with-param name="data_url" select="$_data_url" />
      <xsl:with-param name="data_gid" select="$_data_gid" />
      <xsl:with-param name="arg0" select="$arg0" />
      <xsl:with-param name="arg1" select="$arg1" />
      <xsl:with-param name="arg2" select="$arg2" />
     </xsl:apply-templates>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
