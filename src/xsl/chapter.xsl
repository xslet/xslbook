<?xml version="1.0" encoding="utf8"?>

<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="preface|chapter|appendix|postface">
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A flag if text node is allowed. -->
  <xsl:param name="allow_text_node" select="$ut:true"/>
  <!--** Elements which are denied to be applied. -->
  <xsl:param name="deny">|attr|</xsl:param>
  <!--** Any argument 0. -->
  <xsl:param name="arg0"/>
  <!--** Any argument 1. -->
  <xsl:param name="arg1"/>
  <!--** Any argument 2. -->
  <xsl:param name="arg2"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_chapter_type" select="name()"/>
  <xsl:variable name="_chapter_index">
   <xsl:call-template name="bk:_get_chapter_index">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="chapter_type" select="$_chapter_type"/>
   </xsl:call-template>
  </xsl:variable>
  <section class="{$_chapter_type}">
   <xsl:call-template name="bk:set_id"/>
   <xsl:apply-templates select="title|for|if|choose">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="allow">|title|for|if|choose|</xsl:with-param>
    <xsl:with-param name="allow_text_node"/>
    <xsl:with-param name="arg0">h2</xsl:with-param>
    <xsl:with-param name="arg1" select="$_chapter_type"/>
    <xsl:with-param name="arg2" select="$_chapter_index"/>
   </xsl:apply-templates>
   <xsl:apply-templates select="body|toc|section">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="arg0"/>
    <xsl:with-param name="arg1" select="$_chapter_type"/>
    <xsl:with-param name="arg2" select="$_chapter_index"/>
   </xsl:apply-templates>
  </section>
 </xsl:template>

 <xsl:template name="bk:_get_chapter_index">
  <xsl:param name="data_url"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="page_index" select="$bk:page_index"/>
  <xsl:choose>
   <xsl:when test="$chapter_type = 'preface'">
    <xsl:if test="string-length($bk:preface_index_format) &gt; 0">
     <xsl:call-template name="bk:_format_chapter_index">
      <xsl:with-param name="index_format" select="$bk:preface_index_format"/>
      <xsl:with-param name="index_in_page">
       <xsl:number level="multiple" format="1" count="preface"/>
      </xsl:with-param>
      <xsl:with-param name="count_until_prev_page">
       <xsl:call-template name="bk:_count_until_prev_page">
        <xsl:with-param name="chapter_type" select="$chapter_type"/>
        <xsl:with-param name="page_index" select="$page_index"/>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </xsl:when>
   <xsl:when test="$chapter_type = 'postface'">
    <xsl:if test="string-length($bk:postface_index_format) &gt; 0">
     <xsl:call-template name="bk:_format_chapter_index">
      <xsl:with-param name="index_format" select="$bk:postface_index_format"/>
      <xsl:with-param name="index_in_page">
       <xsl:number level="multiple" format="1" count="postface"/>
      </xsl:with-param>
      <xsl:with-param name="count_until_prev_page">
       <xsl:call-template name="bk:_count_until_prev_page">
        <xsl:with-param name="chapter_type" select="$chapter_type"/>
        <xsl:with-param name="page_index" select="$page_index"/>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </xsl:when>
   <xsl:when test="$chapter_type = 'appendix'">
    <xsl:if test="string-length($bk:appendix_index_format) &gt; 0">
     <xsl:call-template name="bk:_format_chapter_index">
      <xsl:with-param name="index_format" select="$bk:appendix_index_format"/>
      <xsl:with-param name="index_in_page">
       <xsl:number level="multiple" format="1" count="appendix"/>
      </xsl:with-param>
      <xsl:with-param name="count_until_prev_page">
       <xsl:call-template name="bk:_count_until_prev_page">
        <xsl:with-param name="chapter_type" select="$chapter_type"/>
        <xsl:with-param name="page_index" select="$page_index"/>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </xsl:when>
   <xsl:otherwise>
    <xsl:if test="string-length($bk:chapter_index_format) &gt; 0">
     <xsl:call-template name="bk:_format_chapter_index">
      <xsl:with-param name="index_format" select="$bk:chapter_index_format"/>
      <xsl:with-param name="index_in_page">
       <xsl:number level="multiple" format="1" count="chapter"/>
      </xsl:with-param>
      <xsl:with-param name="count_until_prev_page">
       <xsl:call-template name="bk:_count_until_prev_page">
        <xsl:with-param name="chapter_type" select="$chapter_type"/>
        <xsl:with-param name="page_index" select="$page_index"/>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="bk:_format_chapter_index">
  <xsl:param name="index_format"/>
  <xsl:param name="index_in_page"/>
  <xsl:param name="count_until_prev_page">0</xsl:param>
  <xsl:variable name="_n" select="$count_until_prev_page + $index_in_page"/>
  <xsl:number format="{$index_format}" value="$_n"/>
 </xsl:template>

 <xsl:template name="bk:_count_until_prev_page">
  <xsl:param name="chapter_type"/>
  <xsl:param name="page_index" select="$bk:page_index"/>
  <xsl:choose>
   <xsl:when test="string-length($bk:toc_url) &gt; 0">
    <xsl:for-each select="document($bk:toc_url, /)/book/toc[1]">
     <xsl:value-of select="count(document((.//page)[position() &lt; $page_index]/@href, /)/book/*[name() = $chapter_type])"/>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="section">
  <!--** An URL of external data file. -->
  <xsl:param name="data_url"/>
  <!--** A flag if text node is allowed. -->
  <xsl:param name="allow_text_node" select="$ut:true"/>
  <!--** Elements which are denied to be applied. -->
  <xsl:param name="deny">|attr|</xsl:param>
  <!--** Any argument 0. -->
  <xsl:param name="arg0"/>
  <!--** Any argument 1. -->
  <xsl:param name="arg1"/>
  <!--** Any argument 2. -->
  <xsl:param name="arg2"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_chapter_type" select="$arg1"/>
  <xsl:variable name="_chapter_index">
   <xsl:if test="string-length($arg2) != 0">
    <xsl:value-of select="$arg2"/>
    <xsl:number level="single" count="section" format="{$bk:section_index_format}"/>
   </xsl:if>
  </xsl:variable>
  <section class="section">
   <xsl:call-template name="bk:set_id"/>
   <xsl:apply-templates select="title|for|if|choose">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="allow">|title|for|if|choose|</xsl:with-param>
    <xsl:with-param name="allow_text_node"/>
    <xsl:with-param name="arg0">h3</xsl:with-param>
    <xsl:with-param name="arg1" select="$_chapter_type"/>
    <xsl:with-param name="arg2" select="$_chapter_index"/>
   </xsl:apply-templates>
   <xsl:apply-templates select="body|toc|section">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="arg0"/>
    <xsl:with-param name="arg1" select="$_chapter_type"/>
    <xsl:with-param name="arg2" select="$_chapter_index"/>
   </xsl:apply-templates>
  </section>
 </xsl:template>

</xsl:stylesheet>
