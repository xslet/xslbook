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
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url"/>
  </xsl:variable>
  <html>
   <head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>
     <xsl:apply-templates select="title">
      <xsl:with-param name="data_url" select="$_data_url"/>
      <xsl:with-param name="allow">|title|fo|if|case|</xsl:with-param>
     </xsl:apply-templates>
    </title>
    <xsl:call-template name="bk:_load_default_script"/>
    <xsl:call-template name="bk:_load_default_css"/>
   </head>
   <body>
    <main>
     <header>
     </header>
     <article class="book">
      <xsl:apply-templates select="title|for|if|case">
       <xsl:with-param name="data_url" select="$_data_url"/>
       <xsl:with-param name="allow">|title|for|if|case|</xsl:with-param>
       <xsl:with-param name="arg0">h1</xsl:with-param>
      </xsl:apply-templates>
      <div class="body">
       <xsl:apply-templates select="body">
        <xsl:with-param name="allow_text_node" select="$ut:true"/>
       </xsl:apply-templates>
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

 <xsl:template match="title">
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:param name="arg0"/><!-- Tag Name -->
  <xsl:param name="arg1"/>
  <xsl:param name="arg2"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_data_gid">
   <xsl:call-template name="bk:get_data_gid">
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($arg0) != 0">
    <xsl:element name="{$arg0}">
     <xsl:apply-templates>
      <xsl:with-param name="data_url" select="$_data_url"/>
      <xsl:with-param name="data_gid" select="$_data_gid"/>
      <xsl:with-param name="arg0" select="''"/>
      <xsl:with-param name="arg1" select="$arg1"/>
      <xsl:with-param name="arg2" select="$arg2"/>
     </xsl:apply-templates>
    </xsl:element>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates>
     <xsl:with-param name="data_url" select="$_data_url"/>
     <xsl:with-param name="data_gid" select="$_data_gid"/>
     <xsl:with-param name="arg0" select="''"/>
     <xsl:with-param name="arg1" select="$arg1"/>
     <xsl:with-param name="arg2" select="$arg2"/>
    </xsl:apply-templates>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="body">
  <xsl:param name="data_url"/>
  <xsl:param name="data_gid"/>
  <xsl:param name="allow"/>
  <xsl:param name="allow_text_node"/>
  <xsl:param name="arg0"/>
  <xsl:param name="arg1"/>
  <xsl:param name="arg2"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_data_gid">
   <xsl:call-template name="bk:get_data_gid">
    <xsl:with-param name="data_gid" select="$data_gid"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:apply-templates>
   <xsl:with-param name="data_url" select="$_data_url"/>
   <xsl:with-param name="data_gid" select="$_data_gid"/>
   <xsl:with-param name="allow" select="$allow"/>
   <xsl:with-param name="allow_text_node" select="$allow_text_node"/>
   <xsl:with-param name="arg0" select="$arg0"/>
   <xsl:with-param name="arg1" select="$arg1"/>
   <xsl:with-param name="arg2" select="$arg2"/>
  </xsl:apply-templates>
 </xsl:template>

</xsl:stylesheet>
