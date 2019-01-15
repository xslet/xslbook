<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/sttk/xslet/2019/xslutil"
 xmlns:bk="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:param name="bk:xsl_url">
  <xsl:call-template name="ut:get_xsl_url"/>
 </xsl:param>

 <xsl:param name="bk:xsl_dir">
  <xsl:call-template name="ut:get_dir_from_url">
   <xsl:with-param name="url" select="$bk:xsl_url"/>
  </xsl:call-template>
 </xsl:param>

 <xsl:template match="/xslbook">
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url"/>
  </xsl:variable>
  <html>
  <head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
   <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
   <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
   <xsl:call-template name="bk:write_window_title">
    <xsl:with-param name="data_url" select="$_data_url"/>
   </xsl:call-template>
   <xsl:call-template name="bk:write_default_css_link"/>
   <xsl:apply-templates select="css"/>
   <xsl:call-template name="bk:write_default_script_link"/>
   <xsl:apply-templates select="script"/>
  </head>
  <body>
   <header>
    <xsl:call-template name="bk:write_navi_header"/>
   </header>
   <main>
    <section class="xslbook">
     <xsl:call-template name="bk:set_id"/>
     <xsl:call-template name="bk:write_book_title">
      <xsl:with-param name="data_url" select="$_data_url"/>
     </xsl:call-template>
     <xsl:apply-templates select="body|toc|preface|chapter|appendix|postface">
      <xsl:with-param name="data_url" select="$_data_url"/>
     </xsl:apply-templates>
    </section>
   </main>
   <footer>
    <xsl:call-template name="bk:write_navi_footer"/>
   </footer>
  </body>
  </html>
 </xsl:template>

 <xsl:template name="bk:get_data_url">
  <xsl:param name="data_url"/>
  <xsl:choose>
   <xsl:when test="boolean(@data-src)">
    <xsl:value-of select="@data-src"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$data_url"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="bk:write_window_title">
  <xsl:param name="data_url"/>
  <title>
   <xsl:choose>
    <xsl:when test="boolean(/xslbook/title)">
     <xsl:apply-templates select="/xslbook/title[1]">
      <xsl:with-param name="data_url" select="$data_url"/>
     </xsl:apply-templates>
    </xsl:when>
    <xsl:when test="string-length($bk:toc_url) &gt; 0">
     <xsl:for-each select="document($bk:toc_url,/)">
      <xsl:apply-templates select="/xslbook/title[1]">
       <xsl:with-param name="data_url" select="$data_url"/>
      </xsl:apply-templates>
     </xsl:for-each>
    </xsl:when>
   </xsl:choose>
  </title>
 </xsl:template>

 <xsl:template name="bk:write_book_title">
  <xsl:param name="data_url"/>
  <xsl:if test="boolean(/xslbook/title)">
   <h1 class="title">
    <xsl:apply-templates select="/xslbook/title[1]">
     <xsl:with-param name="data_url" select="$data_url"/>
    </xsl:apply-templates>
   </h1>
  </xsl:if>
 </xsl:template>

 <xsl:template match="/xslbook/css">
  <xsl:choose>
   <xsl:when test="boolean(@href)">
    <link rel="stylesheet" href="{@href}"/>
   </xsl:when>
   <xsl:when test="boolean(@rpath)">
    <link rel="stylesheet" href="{concat($bk:xsl_dir, '/', @rpath)}"/>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="/xslbook/script">
  <xsl:choose>
   <xsl:when test="boolean(@href)">
    <script src="{@href}"></script>
   </xsl:when>
   <xsl:when test="boolean(@rpath)">
    <script src="{concat($bk:xsl_dir, '/', @rpath)}"></script>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="bk:write_default_css_link">
  <xsl:if test="not(boolean(css))">
   <link rel="stylesheet" href="{concat($bk:xsl_dir, '/xslbook.css')}"/>
  </xsl:if>
 </xsl:template>

 <xsl:template name="bk:write_default_script_link">
  <script src="{concat($bk:xsl_dir, '/xslbook.js')}"></script>
 </xsl:template>

 <xsl:template name="bk:set_id">
  <xsl:attribute name="id">
   <xsl:call-template name="bk:get_id"/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template name="bk:get_id">
  <xsl:choose>
   <xsl:when test="boolean(@id)">
    <xsl:value-of select="@id"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:text>idxbk</xsl:text>
    <xsl:variable name="_tag_name" select="local-name()"/>
    <xsl:value-of select="$_tag_name"/>
    <xsl:number level="any" format="1" count="*[local-name() = $_tag_name]"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="body">
  <xsl:param name="data_url"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <div class="body">
   <xsl:apply-templates>
    <xsl:with-param name="data_url" select="$_data_url"/>
   </xsl:apply-templates>
  </div>
 </xsl:template>

</xsl:stylesheet>
