<?xml version="1.0" encoding="utf-8"?>                                          
<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="/xslbook">
  <xsl:variable name="_data_url">
   <xsl:call-template name="book:get_data_url"/>
  </xsl:variable>
  <html>
   <head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1.0"/>
    <title>
     <xsl:call-template name="book:get_window_title">
      <xsl:with-param name="data_url" select="$_data_url"/>
     </xsl:call-template>
    </title>
    <xsl:call-template name="book:use_css">
     <xsl:with-param name="data_url" select="$_data_url"/>
    </xsl:call-template>
   </head>
   <body>
    <main>
     <xsl:apply-templates select="title|body|subtitle[not(@top-of or @left-of or @right-of or @bottom-of)]" mode="xslbook">
      <xsl:with-param name="data_url" select="$_data_url"/>
     </xsl:apply-templates>
    </main>
   </body>
  </html>
 </xsl:template>

</xsl:stylesheet>
