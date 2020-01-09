<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--** The URL of the XSL file. -->
 <xsl:param name="bk:xsl_url">
  <xsl:call-template name="ut:get_xsl_url"/>
 </xsl:param>

 <!--** The directory URL of the XSL file. -->
 <xsl:param name="bk:xsl_dir">
  <xsl:call-template name="ut:get_dir_from_url">
   <xsl:with-param name="url" select="$bk:xsl_url"/>
  </xsl:call-template>
 </xsl:param>

 <!--**
   The topmost element of xslbook document.
 -->
 <xsl:template match="/book|/xslbook">
  <html>
   <head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title><xsl:apply-templates select="title"/></title>
    <xsl:call-template name="bk:_load_default_script"/>
    <xsl:call-template name="bk:_load_default_css"/>
   </head>
   <body>
    <main>
     <header>
     </header>
     <article class="book">
      <h1><xsl:apply-templates select="title"/></h1>
      <div class="body">
       <xsl:apply-templates select="body"/>
      </div>
     </article>
     <footer>
     </footer>
    </main>
   </body>
  </html>
 </xsl:template>

 <xsl:template name="bk:_load_default_script">
  <script src="{concat($bk:xsl_dir, '/xslbook.js')}"></script>
 </xsl:template>

 <xsl:template name="bk:_load_default_css">
  <xsl:if test="not(boolean(css))">
   <link rel="stylesheet" href="{concat($bk:xsl_dir, '/xslbook.css')}"/>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
