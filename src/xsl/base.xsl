<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:util="https://github.com/sttk/xslet/2019/util"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:param name="book:xsl_url">
  <xsl:call-template name="util:get_xsl_url"/>
 </xsl:param>

 <xsl:param name="book:xsl_dir">
  <xsl:call-template name="util:get_dir_from_url">
   <xsl:with-param name="url" select="$book:xsl_url"/>
  </xsl:call-template>
 </xsl:param>

 <xsl:template match="/xslbook">
  <xsl:variable name="_data_url">
   <xsl:call-template name="book:get_data_url"/>
  </xsl:variable>
  <html>
  <head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
   <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
   <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
   <xsl:call-template name="book:control_window_title">
    <xsl:with-param name="data_url" select="$_data_url"/>
   </xsl:call-template>
   <xsl:call-template name="book:control_default_css_link"/>
   <xsl:apply-templates select="css"/>
   <xsl:call-template name="book:write_default_script_link"/>
   <xsl:apply-templates select="script"/>
  </head>
  <body>
   <header>
    <xsl:call-template name="book:control_header"/>
   </header>
   <main>
    <section class="xslbook">
     <xsl:call-template name="book:set_id"/>
     <xsl:call-template name="book:control_book_title">
      <xsl:with-param name="data_url" select="$_data_url"/>
     </xsl:call-template>
     <xsl:apply-templates select="body|toc|preface|chapter|appendix|postface">
      <xsl:with-param name="data_url" select="$_data_url"/>
     </xsl:apply-templates>
    </section>
   </main>
   <footer>
    <xsl:call-template name="book:control_footer"/>
   </footer>
  </body>
  </html>
 </xsl:template>

 <xsl:template name="book:get_data_url">
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

 <xsl:template name="book:control_window_title">
  <xsl:param name="data_url"/>
  <xsl:choose>
   <xsl:when test="boolean(/xslbook/title)">
    <xsl:call-template name="book:write_window_title">
     <xsl:with-param name="data_url" select="$data_url"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:when test="string-length($book:toc_url) &gt; 0">
    <xsl:for-each select="document($book:toc_url,/)">
     <xsl:call-template name="book:write_window_title">
      <xsl:with-param name="data_url" select="$data_url"/>
     </xsl:call-template>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <title></title>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:write_window_title">
  <xsl:param name="data_url"/>
  <title>
   <xsl:apply-templates select="/xslbook/title[1]">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:apply-templates>
  </title>
 </xsl:template>

 <xsl:template name="book:control_book_title">
  <xsl:param name="data_url"/>
  <xsl:if test="boolean(/xslbook/title)">
   <xsl:call-template name="book:write_book_title">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>

 <xsl:template name="book:write_book_title">
  <xsl:param name="data_url"/>
  <h1 class="title">
   <span class="label">
    <xsl:apply-templates select="/xslbook/title[1]">
     <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:apply-templates>
   </span>
  </h1>
 </xsl:template>

 <xsl:template match="/xslbook/css">
  <xsl:choose>
   <xsl:when test="boolean(@href)">
    <link rel="stylesheet" href="{@href}"/>
   </xsl:when>
   <xsl:when test="boolean(@rpath)">
    <link rel="stylesheet" href="{concat($book:xsl_dir, '/', @rpath)}"/>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="/xslbook/script">
  <xsl:choose>
   <xsl:when test="boolean(@href)">
    <script src="{@href}"></script>
   </xsl:when>
   <xsl:when test="boolean(@rpath)">
    <script src="{concat($book:xsl_dir, '/', @rpath)}"></script>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:control_default_css_link">
  <xsl:if test="not(boolean(css))">
   <link rel="stylesheet" href="{concat($book:xsl_dir, '/xslbook.css')}"/>
  </xsl:if>
 </xsl:template>

 <xsl:template name="book:write_default_script_link">
  <script src="{concat($book:xsl_dir, '/xslbook.js')}"></script>
 </xsl:template>

 <xsl:template name="book:control_header">
  <xsl:call-template name="book:control_navi"/>
 </xsl:template>

 <xsl:template name="book:control_footer">
  <xsl:call-template name="book:control_navi"/>
 </xsl:template>

 <xsl:template name="book:set_id">
  <xsl:attribute name="id">
   <xsl:call-template name="book:get_id"/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template name="book:get_id">
  <xsl:choose>
   <xsl:when test="boolean(@id)">
    <xsl:value-of select="@id"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:text>idxbk</xsl:text>
    <xsl:variable name="_tag_name" select="local-name()"/>
    <xsl:value-of select="$_tag_name"/>
    <xsl:number level="any" format="1" count="*[name() = $_tag_name]"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="body">
  <xsl:param name="data_url"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="book:get_data_url">
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
