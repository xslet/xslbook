<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/sttk/xslet/2019/xslutil"
 xmlns:bk="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="preface|chapter|appendix|postface">
  <xsl:param name="data_url"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_chapter_type" select="local-name()"/>
  <xsl:variable name="_chapter_index">
   <xsl:call-template name="bk:get_chapter_index">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="chapter_type" select="$_chapter_type"/>
   </xsl:call-template>
  </xsl:variable>
  <section class="{$_chapter_type}">
   <xsl:call-template name="bk:set_id"/>
   <xsl:call-template name="bk:write_chapter_title">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="chapter_type" select="$_chapter_type"/>
    <xsl:with-param name="chapter_index" select="$_chapter_index"/>
   </xsl:call-template>
   <xsl:apply-templates select="body|toc|clause">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="chapter_type" select="$_chapter_type"/>
    <xsl:with-param name="chapter_index" select="$_chapter_index"/>
   </xsl:apply-templates>
  </section>
 </xsl:template>

 <xsl:template name="bk:get_chapter_index">
  <xsl:param name="data_url"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="page_index" select="$bk:page_index"/>
  <xsl:choose>
   <xsl:when test="$chapter_type = 'preface'">
    <xsl:if test="string-length($bk:preface_index_format) &gt; 0">
     <xsl:call-template name="bk:format_chapter_index">
      <xsl:with-param name="index_format" select="$bk:preface_index_format"/>
      <xsl:with-param name="index_in_page">
       <xsl:number level="multiple" format="1" count="preface"/>
      </xsl:with-param>
      <xsl:with-param name="count_until_prev_page">
       <xsl:call-template name="bk:count_until_prev_page">
        <xsl:with-param name="chapter_type" select="$chapter_type"/>
        <xsl:with-param name="page_index" select="$page_index"/>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </xsl:when>
   <xsl:when test="$chapter_type = 'postface'">
    <xsl:if test="string-length($bk:postface_index_format) &gt; 0">
     <xsl:call-template name="bk:format_chapter_index">
      <xsl:with-param name="index_format" select="$bk:postface_index_format"/>
      <xsl:with-param name="index_in_page">
       <xsl:number level="multiple" format="1" count="postface"/>
      </xsl:with-param>
      <xsl:with-param name="count_until_prev_page">
       <xsl:call-template name="bk:count_until_prev_page">
        <xsl:with-param name="chapter_type" select="$chapter_type"/>
        <xsl:with-param name="page_index" select="$page_index"/>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </xsl:when>
   <xsl:when test="$chapter_type = 'appendix'">
    <xsl:if test="string-length($bk:appendix_index_format) &gt; 0">
     <xsl:call-template name="bk:format_chapter_index">
      <xsl:with-param name="index_format" select="$bk:appendix_index_format"/>
      <xsl:with-param name="index_in_page">
       <xsl:number level="multiple" format="1" count="appendix"/>
      </xsl:with-param>
      <xsl:with-param name="count_until_prev_page">
       <xsl:call-template name="bk:count_until_prev_page">
        <xsl:with-param name="chapter_type" select="$chapter_type"/>
        <xsl:with-param name="page_index" select="$page_index"/>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </xsl:when>
   <xsl:otherwise>
    <xsl:if test="string-length($bk:chapter_index_format) &gt; 0">
     <xsl:call-template name="bk:format_chapter_index">
      <xsl:with-param name="index_format" select="$bk:chapter_index_format"/>
      <xsl:with-param name="index_in_page">
       <xsl:number level="multiple" format="1" count="chapter"/>
      </xsl:with-param>
      <xsl:with-param name="count_until_prev_page">
       <xsl:call-template name="bk:count_until_prev_page">
        <xsl:with-param name="chapter_type" select="$chapter_type"/>
        <xsl:with-param name="page_index" select="$page_index"/>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="bk:format_chapter_index">
  <xsl:param name="count_until_prev_page" select="'0'"/>
  <xsl:param name="index_in_page"/>
  <xsl:param name="index_format"/>
  <xsl:variable name="_n" select="$count_until_prev_page + $index_in_page"/>
  <xsl:number format="{$index_format}" value="$_n"/>
 </xsl:template>

 <xsl:template name="bk:write_chapter_title">
  <xsl:param name="data_url"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <h2 class="title">
   <span class="index">
    <xsl:value-of select="$chapter_index"/>
   </span>
   <span class="label">
    <xsl:apply-templates select="title">
     <xsl:with-param name="data_url" select="$data_url"/>
    </xsl:apply-templates>
   </span>
  </h2>
 </xsl:template>

 <xsl:template match="clause">
  <xsl:param name="data_url"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <section class="clause">
   <xsl:call-template name="bk:set_id"/>
   <xsl:call-template name="bk:write_clause_title">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="chapter_type" select="$chapter_type"/>
    <xsl:with-param name="chapter_index" select="$chapter_index"/>
   </xsl:call-template>
   <xsl:apply-templates select="body|toc|section">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="chapter_type" select="$chapter_type"/>
    <xsl:with-param name="chapter_index" select="$chapter_index"/>
   </xsl:apply-templates>
  </section>
 </xsl:template>

 <xsl:template name="bk:write_clause_title">
  <xsl:param name="data_url"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <h3 class="title">
   <span class="index">
    <xsl:value-of select="$chapter_index"/>
    <xsl:if test="string-length($chapter_index) &gt; 0">
     <xsl:number level="multiple" count="clause"
      format="{$bk:clause_index_format}"/>
    </xsl:if>
   </span>
   <span class="label">
    <xsl:apply-templates select="title">
     <xsl:with-param name="data_url" select="$data_url"/>
    </xsl:apply-templates>
   </span>
  </h3>
 </xsl:template>

 <xsl:template match="section">
  <xsl:param name="data_url"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <section class="section">
   <xsl:call-template name="bk:set_id"/>
   <xsl:call-template name="bk:write_section_title">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="chapter_type" select="$chapter_type"/>
    <xsl:with-param name="chapter_index" select="$chapter_index"/>
   </xsl:call-template>
   <xsl:apply-templates select="body|toc|section">
    <xsl:with-param name="data_url" select="$_data_url"/>
    <xsl:with-param name="chapter_type" select="$chapter_type"/>
    <xsl:with-param name="chapter_index" select="$chapter_index"/>
   </xsl:apply-templates>
  </section>
 </xsl:template>

 <xsl:template name="bk:write_section_title">
  <xsl:param name="data_url"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <h4 class="title">
   <span class="index">
    <xsl:value-of select="$chapter_index"/>
    <xsl:if test="string-length($chapter_index) &gt; 0">
     <xsl:number level="multiple" count="clause|section"
      format="{$bk:clause_index_format}{$bk:section_index_format}"/>
    </xsl:if>
   </span>
   <span class="label">
    <xsl:apply-templates select="title">
     <xsl:with-param name="data_url" select="$data_url"/>
    </xsl:apply-templates>
   </span>
  </h4>
 </xsl:template>

</xsl:stylesheet>
