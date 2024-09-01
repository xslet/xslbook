<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:book="https://github.com/xslet/2020/xslbook">

 <!--**
  Gets the URL of the XSL file to transform a XML file.
 -->
 <xsl:param name="book:xsl_url">
  <xsl:call-template name="ut:get_xsl_url"/>
 </xsl:param>


 <!--**
  Get the directory path of the XSL file to transform a XML file.
 -->
 <xsl:param name="book:xsl_dir">
  <xsl:call-template name="ut:get_dir_from_url">
   <xsl:with-param name="url" select="$book:xsl_url"/>
  </xsl:call-template>
 </xsl:param>

</xsl:stylesheet>
