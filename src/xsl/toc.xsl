<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="toc">
  <xsl:param name="data_url"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="book:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_toc_target">
   <xsl:call-template name="book:get_toc_target">
    <xsl:with-param name="default_target" select="$book:default_toc_target"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_is_toc_page">
   <xsl:if test="string-length($book:toc_url) &gt; 0">
    <xsl:if test="boolean(.//page)">
     <xsl:value-of select="generate-id(document($book:page_url,/)) = generate-id(document($book:toc_url,/))"/>
    </xsl:if>
   </xsl:if>
  </xsl:variable>
  <nav class="toc">
   <xsl:call-template name="book:set_id"/>
   <xsl:call-template name="book:write_toc_title">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
   <div class="body">
    <xsl:choose>
     <xsl:when test="$_is_toc_page = 'true'">
      <xsl:call-template name="book:control_toc_in_page_or_part">
       <xsl:with-param name="data_url" select="$_data_url"/>
       <xsl:with-param name="toc_target" select="$_toc_target"/>
       <xsl:with-param name="chapter_type" select="$chapter_type"/>
       <xsl:with-param name="chapter_index" select="$chapter_index"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
      <xsl:for-each select="..">
       <xsl:call-template name="book:control_toc_in_page">
        <xsl:with-param name="data_url" select="$_data_url"/>
        <xsl:with-param name="toc_target" select="$_toc_target"/>
        <xsl:with-param name="chapter_type" select="$chapter_type"/>
        <xsl:with-param name="chapter_index" select="$chapter_index"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:otherwise>
    </xsl:choose>
   </div>
  </nav>
 </xsl:template>

 <xsl:template name="book:write_toc_of_part">
  <xsl:param name="data_url"/>
  <h3 class="title">
   <xsl:apply-templates select="title">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:apply-templates>
  </h3>
 </xsl:template>

 <xsl:template name="book:control_toc_in_page_or_part">
  <xsl:param name="data_url"/>
  <xsl:param name="toc_target"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <xsl:for-each select="part|page">
   <xsl:variable name="_gid" select="generate-id()"/>
   <xsl:choose>
    <xsl:when test="name() = 'part'">
     <div class="toc-part">
      <xsl:call-template name="book:write_toc_of_part">
       <xsl:with-param name="data_url" select="$data_url"/>
      </xsl:call-template>
      <xsl:call-template name="book:control_toc_in_page_or_part">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="toc_target" select="$toc_target"/>
       <xsl:with-param name="chapter_type" select="$chapter_type"/>
       <xsl:with-param name="chapter_index" select="$chapter_index"/>
      </xsl:call-template>
     </div>
    </xsl:when>
    <xsl:otherwise>
     <xsl:variable name="_page_index" select="count(//*[generate-id() = $_gid]/preceding::page) +1"/>
     <xsl:variable name="_page_url" select="@url"/>
     <xsl:for-each select="document(@url,/)/xslbook">
      <xsl:call-template name="book:control_toc_in_page">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="toc_target" select="$toc_target"/>
       <xsl:with-param name="chapter_type" select="$chapter_type"/>
       <xsl:with-param name="chapter_index" select="$chapter_index"/>
       <xsl:with-param name="page_index" select="$_page_index"/>
       <xsl:with-param name="page_url" select="$_page_url"/>
      </xsl:call-template>
     </xsl:for-each>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="book:control_toc_in_page">
  <xsl:param name="data_url"/>
  <xsl:param name="toc_target"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <xsl:param name="page_index" select="$book:page_index"/>
  <xsl:param name="page_url" select="$book:page_url"/>
  <xsl:choose>
   <xsl:when test="name() = 'xslbook'">
    <xsl:call-template name="book:control_toc_of_chapter">
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="toc_target" select="$toc_target"/>
     <xsl:with-param name="page_index" select="$page_index"/>
     <xsl:with-param name="page_url" select="$page_url"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:when test="name(..) = 'xslbook'">
    <xsl:call-template name="book:control_toc_of_clause">
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="toc_target" select="$toc_target"/>
     <xsl:with-param name="chapter_type" select="$chapter_type"/>
     <xsl:with-param name="chapter_index" select="$chapter_index"/>
     <xsl:with-param name="page_url" select="$page_url"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:when test="name() = 'clause' or name() = 'section'">
    <xsl:call-template name="book:control_toc_of_section">
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="toc_target" select="$toc_target"/>
     <xsl:with-param name="chapter_type" select="$chapter_type"/>
     <xsl:with-param name="chapter_index" select="$chapter_index"/>
     <xsl:with-param name="page_url" select="$page_url"/>
    </xsl:call-template>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:get_toc_target">
  <xsl:param name="default_target"/>
  <xsl:choose>
   <xsl:when test="string-length(@target) &gt; 0">
    <xsl:value-of select="concat('|', @target, '|')"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$default_target"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:write_toc_title">
  <xsl:param name="data_url"/>
  <xsl:choose>
   <xsl:when test="boolean(title)">
    <h2 class="title">
     <xsl:apply-templates select="title">
      <xsl:with-param name="data_url" select="$data_url"/>
     </xsl:apply-templates>
    </h2>
   </xsl:when>
   <xsl:otherwise>
    <h2 class="title">
     <xsl:value-of select="$book:default_toc_title"/>
    </h2>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:write_toc_of_chapter">
  <xsl:param name="data_url"/>
  <xsl:param name="page_url"/>
  <xsl:param name="chapter_id"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <a class="title">
   <xsl:attribute name="href">
    <xsl:value-of select="concat($page_url, '#', $chapter_id)"/>
   </xsl:attribute>
   <span class="index index-in-{$chapter_type}">
    <xsl:value-of select="$chapter_index"/>
   </span>
   <span class="label">
    <xsl:apply-templates select="title">
     <xsl:with-param name="data_url" select="$data_url"/>
    </xsl:apply-templates>
   </span>
  </a>
 </xsl:template>

 <xsl:template name="book:control_toc_of_chapter">
  <xsl:param name="data_url"/>
  <xsl:param name="toc_target"/>
  <xsl:param name="page_index"/>
  <xsl:param name="page_url"/>
  <xsl:for-each select="preface|chapter|appendix|postface">
   <xsl:variable name="_chapter_id">
    <xsl:call-template name="book:get_id"/>
   </xsl:variable>
   <xsl:variable name="_chapter_type" select="name()"/>
   <xsl:variable name="_chapter_index">
    <xsl:call-template name="book:get_chapter_index">
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="chapter_type" select="$_chapter_type"/>
     <xsl:with-param name="page_index" select="$page_index"/>
    </xsl:call-template>
   </xsl:variable>
   <xsl:choose>
    <xsl:when test="contains($toc_target, concat('|',$_chapter_type,'|'))">
     <div class="toc-{$_chapter_type}">
      <xsl:call-template name="book:write_toc_of_chapter">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="page_url" select="$page_url"/>
       <xsl:with-param name="chapter_id" select="$_chapter_id"/>
       <xsl:with-param name="chapter_type" select="$_chapter_type"/>
       <xsl:with-param name="chapter_index" select="$_chapter_index"/>
      </xsl:call-template>
      <xsl:call-template name="book:control_toc_of_clause">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="toc_target" select="$toc_target"/>
       <xsl:with-param name="chapter_type" select="$_chapter_type"/>
       <xsl:with-param name="chapter_index" select="$_chapter_index"/>
       <xsl:with-param name="page_url" select="$page_url"/>
      </xsl:call-template>
     </div>
    </xsl:when>
    <xsl:when test="contains($toc_target, concat('|~',$_chapter_type,'|'))">
     <xsl:call-template name="book:control_toc_of_clause">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="toc_target" select="$toc_target"/>
      <xsl:with-param name="chapter_type" select="$_chapter_type"/>
      <xsl:with-param name="chapter_index" select="$_chapter_index"/>
      <xsl:with-param name="page_url" select="$page_url"/>
     </xsl:call-template>
    </xsl:when>
   </xsl:choose>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="book:write_toc_of_clause">
  <xsl:param name="data_url"/>
  <xsl:param name="page_url"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="clause_id"/>
  <xsl:param name="clause_index"/>
  <a class="title">
   <xsl:attribute name="href">
    <xsl:value-of select="concat($page_url, '#', $clause_id)"/>
   </xsl:attribute>
   <span class="index index-in-{$chapter_type}">
    <xsl:value-of select="$clause_index"/>
   </span>
   <span class="label">
    <xsl:apply-templates select="title">
     <xsl:with-param name="data_url" select="$data_url"/>
    </xsl:apply-templates>
   </span>
  </a>
 </xsl:template>

 <xsl:template name="book:control_toc_of_clause">
  <xsl:param name="data_url"/>
  <xsl:param name="toc_target"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <xsl:param name="page_url"/>
  <xsl:choose>
   <xsl:when test="contains($toc_target, '|clause|')">
    <xsl:for-each select="clause">
     <xsl:variable name="_clause_index">
      <xsl:if test="string-length($chapter_index) &gt; 0">
       <xsl:value-of select="$chapter_index"/>
       <xsl:number level="multiple" count="clause"
         format="{$book:clause_index_format}"/>
      </xsl:if>
     </xsl:variable>
     <xsl:variable name="_clause_id">
      <xsl:call-template name="book:get_id"/>
     </xsl:variable>
     <div class="toc-clause">
      <xsl:call-template name="book:write_toc_of_clause">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="page_url" select="$page_url"/>
       <xsl:with-param name="chapter_type" select="$chapter_type"/>
       <xsl:with-param name="clause_id" select="$_clause_id"/>
       <xsl:with-param name="clause_index" select="$_clause_index"/>
      </xsl:call-template>
      <xsl:call-template name="book:control_toc_of_section">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="toc_target" select="$toc_target"/>
       <xsl:with-param name="chapter_type" select="$chapter_type"/>
       <xsl:with-param name="chapter_index" select="$chapter_index"/>
       <xsl:with-param name="page_url" select="$page_url"/>
      </xsl:call-template>
     </div>
    </xsl:for-each>
   </xsl:when>
   <xsl:when test="contains($toc_target, '|~clause|')">
    <xsl:for-each select="clause">
     <xsl:call-template name="book:control_toc_of_section">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="toc_target" select="$toc_target"/>
      <xsl:with-param name="chapter_type" select="$chapter_type"/>
      <xsl:with-param name="chapter_index" select="$chapter_index"/>
      <xsl:with-param name="page_url" select="$page_url"/>
     </xsl:call-template>
    </xsl:for-each>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:write_toc_of_section">
  <xsl:param name="data_url"/>
  <xsl:param name="page_url"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="section_id"/>
  <xsl:param name="section_index"/>
  <a class="title">
   <xsl:attribute name="href">
    <xsl:value-of select="concat($page_url, '#', $section_id)"/>
   </xsl:attribute>
   <span class="index index-in-{$chapter_type}">
    <xsl:value-of select="$section_index"/>
   </span>
   <span class="label">
    <xsl:apply-templates select="title">
     <xsl:with-param name="data_url" select="$data_url"/>
    </xsl:apply-templates>
   </span>
  </a>
 </xsl:template>

 <xsl:template name="book:control_toc_of_section">
  <xsl:param name="data_url"/>
  <xsl:param name="toc_target"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <xsl:param name="page_url"/>
  <xsl:if test="contains($toc_target, '|section|')">
   <xsl:for-each select="section">
    <xsl:variable name="_section_index">
     <xsl:if test="string-length($chapter_index) &gt; 0">
      <xsl:value-of select="$chapter_index"/>
      <xsl:number level="multiple" count="clause"
        format="{$book:clause_index_format}"/>
      <xsl:number level="multiple" count="section"
        format="{$book:section_index_format}"/>
     </xsl:if>
    </xsl:variable>
    <xsl:variable name="_section_id">
     <xsl:call-template name="book:get_id"/>
    </xsl:variable>
    <div class="toc-section">
     <xsl:call-template name="book:write_toc_of_section">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="page_url" select="$page_url"/>
      <xsl:with-param name="chapter_type" select="$chapter_type"/>
      <xsl:with-param name="section_id" select="$_section_id"/>
      <xsl:with-param name="section_index" select="$_section_index"/>
     </xsl:call-template>
     <xsl:call-template name="book:control_toc_of_section">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="toc_target" select="$toc_target"/>
      <xsl:with-param name="chapter_type" select="$chapter_type"/>
      <xsl:with-param name="chapter_index" select="$chapter_index"/>
      <xsl:with-param name="page_url" select="$page_url"/>
     </xsl:call-template>
    </div>
   </xsl:for-each>
  </xsl:if>
 </xsl:template>

</xsl:stylesheet>
