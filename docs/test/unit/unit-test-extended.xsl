<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:import href="../res/test/unit-test.xsl"/>

 <xsl:template match="value-of-param">
  <xsl:choose>
   <xsl:when test="@name = 'book:xsl_url'">
    <xsl:value-of select="$book:xsl_url"/>
   </xsl:when>
   <xsl:when test="@name = 'book:xsl_dir'">
    <xsl:value-of select="$book:xsl_dir"/>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
