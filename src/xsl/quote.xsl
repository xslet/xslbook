<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:util="https://github.com/sttk/xslet/2019/util"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="quote">
  <xsl:param name="data_url"/>
  <blockquote>
   <div class="quote-content">
    <xsl:apply-templates select="body">
     <xsl:with-param name="data_url" select="$data_url"/>
    </xsl:apply-templates>
   </div>
   <xsl:if test="boolean(source)">
    <div class="quote-source">
     <span class="quote-source">
      <xsl:apply-templates select="source"/>
     </span>
    </div>
   </xsl:if>
  </blockquote>
 </xsl:template>

</xsl:stylesheet>
