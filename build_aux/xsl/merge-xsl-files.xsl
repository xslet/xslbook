<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
 xmlns:xsx="dummy-ns" exclude-result-prefixes="xsx"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:strip-space elements="*"/>
 <xsl:namespace-alias result-prefix="xsl" stylesheet-prefix="xsx"/>

 <xsl:template match="/">
  <xsl:result-document href="xslbook.xsl">
   <xsx:stylesheet version="1.0"
    xmlns:ut="https://github.com/sttk/xslet/2019/xslutil"
    xmlns:bk="https://github.com/sttk/xslet/2019/xslbook">
    <xsl:attribute name="version">1.0</xsl:attribute>
    <xsl:merge>
     <xsl:merge-source for-each-source="uri-collection('../../src/xsl')"
       select="xsl:stylesheet/xsl:param">
      <xsl:merge-key select="name"/>
     </xsl:merge-source>
     <xsl:merge-source for-each-source="uri-collection('../../src/xsl/util')"
       select="xsl:stylesheet/xsl:param">
      <xsl:merge-key select="name"/>
     </xsl:merge-source>
     <xsl:merge-action>
      <xsl:copy-of select="current-merge-group()"/>
     </xsl:merge-action>
    </xsl:merge>
    <xsl:merge>
     <xsl:merge-source for-each-source="uri-collection('../../src/xsl')"
       select="xsl:stylesheet/xsl:template">
      <xsl:merge-key select="name|match"/>
      <xsl:merge-key select="mode"/>
     </xsl:merge-source>
     <xsl:merge-source for-each-source="uri-collection('../../src/xsl/util')"
       select="xsl:stylesheet/xsl:template">
      <xsl:merge-key select="name|match"/>
      <xsl:merge-key select="mode"/>
     </xsl:merge-source>
     <xsl:merge-action>
      <xsl:copy-of select="current-merge-group()"/>
     </xsl:merge-action>
    </xsl:merge>
   </xsx:stylesheet>
  </xsl:result-document>
 </xsl:template>

</xsl:stylesheet>
