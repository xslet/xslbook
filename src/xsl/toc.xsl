<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/sttk/xslet/2019/xslutil"
 xmlns:bk="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="toc">
  <xsl:param name="data_url"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="bk:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_toc_target">
   <xsl:call-template name="bk:get_toc_target">
    <xsl:with-param name="default_target" select="$bk:default_toc_target"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="bk:write_toc">
   <xsl:with-param name="data_url" select="$_data_url"/>
   <xsl:with-param name="toc_target" select="$_toc_target"/>
   <xsl:with-param name="chapter_type" select="$chapter_type"/>
   <xsl:with-param name="chapter_index" select="$chapter_index"/>
  </xsl:call-template>
 </xsl:template>

 <xsl:template name="bk:write_toc">
  <xsl:param name="data_url"/>
  <xsl:param name="toc_target"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <nav class="toc">
   <xsl:call-template name="set_id"/>
   <xsl:call-template name="bk:write_toc_title">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
   <xsl:for-each select="..">
    <xsl:choose>
     <xsl:when test="local-name() = 'xslbook'">
      <xsl:call-template name="bk:write_toc_of_chapter">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="toc_target" select="$toc_target"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:when test="local-name(..) = 'xslbook'">
      <xsl:call-template name="bk:write_toc_of_clause">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="toc_target" select="$toc_target"/>
       <xsl:with-param name="chapter_type" select="$chapter_type"/>
       <xsl:with-param name="chapter_index" select="$chapter_index"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:when test="local-name() = 'clause' or local-name() = 'section'">
      <xsl:call-template name="bk:write_toc_of_section">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="toc_target" select="$toc_target"/>
       <xsl:with-param name="chapter_type" select="$chapter_type"/>
       <xsl:with-param name="chapter_index" select="$chapter_index"/>
      </xsl:call-template>
     </xsl:when>
    </xsl:choose>
   </xsl:for-each>
  </nav>
 </xsl:template>

 <xsl:template name="bk:get_toc_target">
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

 <xsl:template name="bk:write_toc_title">
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
     <xsl:value-of select="$bk:default_toc_title"/>
    </h2>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="bk:write_toc_of_chapter">
  <xsl:param name="data_url"/>
  <xsl:param name="toc_target"/>
  <xsl:for-each select="preface|chapter|appendix|postface">
   <xsl:variable name="_chapter_id" select="@id"/>
   <xsl:variable name="_chapter_type" select="local-name()"/>
   <xsl:variable name="_chapter_index">
    <xsl:call-template name="bk:get_chapter_index">
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="chapter_type" select="$_chapter_type"/>
    </xsl:call-template>
   </xsl:variable>
   <xsl:choose>
    <xsl:when test="contains($toc_target, concat('|',$_chapter_type,'|'))">
     <div class="{$_chapter_type}">
      <a class="title">
       <xsl:attribute name="href">
        <xsl:value-of select="concat('#', $_chapter_id)"/>
       </xsl:attribute>
       <span class="index">
        <xsl:value-of select="$_chapter_index"/>
       </span>
       <span class="label">
        <xsl:apply-templates select="title">
         <xsl:with-param name="data_url" select="$data_url"/>
        </xsl:apply-templates>
       </span>
      </a>
      <xsl:call-template name="bk:write_toc_of_clause">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="toc_target" select="$toc_target"/>
       <xsl:with-param name="chapter_type" select="$_chapter_type"/>
       <xsl:with-param name="chapter_index" select="$_chapter_index"/>
      </xsl:call-template>
     </div>
    </xsl:when>
    <xsl:when test="contains($toc_target, concat('|~',$_chapter_type,'|'))">
     <xsl:call-template name="bk:write_toc_of_clause">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="toc_target" select="$toc_target"/>
      <xsl:with-param name="chapter_type" select="$_chapter_type"/>
      <xsl:with-param name="chapter_index" select="$_chapter_index"/>
     </xsl:call-template>
    </xsl:when>
   </xsl:choose>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="bk:write_toc_of_clause">
  <xsl:param name="data_url"/>
  <xsl:param name="toc_target"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <xsl:choose>
   <xsl:when test="contains($toc_target, '|clause|')">
    <xsl:for-each select="clause">
     <xsl:variable name="_clause_index">
      <xsl:if test="string-length($chapter_index) &gt; 0">
       <xsl:value-of select="$chapter_index"/>
       <xsl:number level="multiple" count="clause"
         format="{$bk:clause_index_format}"/>
      </xsl:if>
     </xsl:variable>
     <div class="clause">
      <a class="title">
       <xsl:attribute name="href">
        <xsl:value-of select="concat('#', @id)"/>
       </xsl:attribute>
       <span class="index">
        <xsl:value-of select="$_clause_index"/>
       </span>
       <span class="label">
        <xsl:apply-templates select="title">
         <xsl:with-param name="data_url" select="$data_url"/>
        </xsl:apply-templates>
       </span>
      </a>
      <xsl:call-template name="bk:write_toc_of_section">
       <xsl:with-param name="data_url" select="$data_url"/>
       <xsl:with-param name="toc_target" select="$toc_target"/>
       <xsl:with-param name="chapter_type" select="$chapter_type"/>
       <xsl:with-param name="chapter_index" select="$chapter_index"/>
      </xsl:call-template>
     </div>
    </xsl:for-each>
   </xsl:when>
   <xsl:when test="contains($toc_target, '|~clause|')">
    <xsl:call-template name="bk:write_toc_of_section">
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="toc_target" select="$toc_target"/>
     <xsl:with-param name="chapter_type" select="$chapter_type"/>
     <xsl:with-param name="chapter_index" select="$chapter_index"/>
    </xsl:call-template>
   </xsl:when>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="bk:write_toc_of_section">
  <xsl:param name="data_url"/>
  <xsl:param name="toc_target"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="chapter_index"/>
  <xsl:for-each select="section">
   <xsl:variable name="_section_index">
    <xsl:if test="string-length($chapter_index) &gt; 0">
     <xsl:value-of select="$chapter_index"/>
     <xsl:number level="multiple" count="clause"
       format="{$bk:clause_index_format}"/>
     <xsl:number level="multiple" count="section"
       format="{$bk:section_index_format}"/>
    </xsl:if>
   </xsl:variable>
   <div class="section">
    <a class="title">
     <xsl:attribute name="href">
      <xsl:value-of select="concat('#', @id)"/>
     </xsl:attribute>
     <span class="index">
      <xsl:value-of select="$_section_index"/>
     </span>
     <span class="label">
      <xsl:apply-templates select="title">
       <xsl:with-param name="data_url" select="$data_url"/>
      </xsl:apply-templates>
     </span>
    </a>
    <xsl:call-template name="bk:write_toc_of_section">
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="toc_target" select="$toc_target"/>
     <xsl:with-param name="chapter_type" select="$chapter_type"/>
     <xsl:with-param name="chapter_index" select="$chapter_index"/>
    </xsl:call-template>
   </div>
  </xsl:for-each>
 </xsl:template>

</xsl:stylesheet>
