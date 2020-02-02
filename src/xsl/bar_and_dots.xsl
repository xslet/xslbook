<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   Prints a bar in text.
 -->
 <xsl:template match="bar">
  <span class="bar">───</span>
 </xsl:template>

 <!--**
   Prints a set of dots in text.
 -->
 <xsl:template match="dots">
  <span class="dots">･･････</span>
 </xsl:template>

</xsl:stylesheet>
