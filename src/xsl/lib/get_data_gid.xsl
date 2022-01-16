<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
  This named template gets a generated ID by `generate-id` function for a current node in a data source file.
  If `data-src` attribute is presented, this template returns an empty string for reset the generated ID.
 -->
 <xsl:template name="book:get_data_gid">
  <!--** A generated ID for a current node in a data source file. -->
  <xsl:param name="data_gid" />
  <xsl:if test="not(boolean(@data-src) or boolean(attr[@name='data-src']))">
   <xsl:value-of select="$data_gid" />
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
