<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="link">
  <xsl:param name="data_url"/>
  <xsl:variable name="_data_url">
   <xsl:call-template name="book:get_data_url">
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="_label">
   <xsl:apply-templates>
    <xsl:with-param name="data_url" select="$_data_url"/>
   </xsl:apply-templates>
  </xsl:variable>
  <xsl:variable name="_only" select="@only"/>
  <xsl:choose>
   <xsl:when test="boolean(@url)">
    <xsl:call-template name="book:write_link_by_url">
     <xsl:with-param name="url" select="@url"/>
     <xsl:with-param name="label" select="$_label"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:when test="boolean(@refid)">
    <xsl:variable name="_refid" select="@refid"/>
    <xsl:choose>
     <xsl:when test="boolean(@page)">
      <xsl:variable name="_page" select="@page"/>
      <xsl:for-each select="document($_page, /)">
       <xsl:call-template name="book:control_link_by_refid_in_this_page">
        <xsl:with-param name="data_url" select="$_data_url"/>
        <xsl:with-param name="refid" select="$_refid"/>
        <xsl:with-param name="label" select="$_label"/>
        <xsl:with-param name="only" select="$_only"/>
        <xsl:with-param name="page" select="$_page"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:when>
     <xsl:when test="string-length($book:toc_url) &gt; 0">
      <xsl:for-each select="document($book:toc_url, /)">
       <xsl:call-template name="book:control_link_by_refid_in_toc_page">
        <xsl:with-param name="data_url" select="$_data_url"/>
        <xsl:with-param name="refid" select="$_refid"/>
        <xsl:with-param name="label" select="$_label"/>
        <xsl:with-param name="only" select="$_only"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:when>
     <xsl:otherwise>
      <xsl:call-template name="book:control_link_by_refid_in_this_page">
       <xsl:with-param name="data_url" select="$_data_url"/>
       <xsl:with-param name="refid" select="$_refid"/>
       <xsl:with-param name="label" select="$_label"/>
       <xsl:with-param name="only" select="$_only"/>
      </xsl:call-template>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="book:write_nolink">
     <xsl:with-param name="refid" select="@refid"/>
     <xsl:with-param name="label" select="$_label"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:control_link_by_refid_in_this_page">
  <xsl:param name="data_url"/>
  <xsl:param name="refid"/>
  <xsl:param name="label"/>
  <xsl:param name="only"/>
  <xsl:param name="page"/>
  <xsl:param name="page_index"/>
  <xsl:choose>
   <xsl:when test="boolean(//*[@id = $refid])">
    <xsl:choose>
     <xsl:when test="string-length($label) &gt; 0">
      <xsl:call-template name="book:write_link_by_refid">
       <xsl:with-param name="refid" select="$refid"/>
       <xsl:with-param name="label" select="$label"/>
       <xsl:with-param name="page" select="$page"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
      <xsl:for-each select="(//*[@id = $refid])[1]">
       <xsl:variable name="_chapter_type">
        <xsl:call-template name="book:get_chapter_type"/>
       </xsl:variable>
       <xsl:variable name="_index">
        <xsl:if test="not($only = 'label')">
         <xsl:variable name="_element_name" select="name()"/>
         <xsl:call-template name="book:get_element_index">
          <xsl:with-param name="data_url" select="$data_url"/>
          <xsl:with-param name="chapter_type" select="$_chapter_type"/>
          <xsl:with-param name="element_name" select="$_element_name"/>
          <xsl:with-param name="page_index" select="$page_index"/>
         </xsl:call-template>
        </xsl:if>
       </xsl:variable>
       <xsl:variable name="_label">
        <xsl:if test="not($only = 'index')">
         <xsl:apply-templates select="title">
          <xsl:with-param name="data_url" select="$data_url"/>
         </xsl:apply-templates>
        </xsl:if>
       </xsl:variable>
       <xsl:call-template name="book:write_title_link_by_refid">
        <xsl:with-param name="refid" select="$refid"/>
        <xsl:with-param name="index" select="$_index"/>
        <xsl:with-param name="label" select="$_label"/>
        <xsl:with-param name="page" select="$page"/>
        <xsl:with-param name="chapter_type" select="$_chapter_type"/>
       </xsl:call-template>
      </xsl:for-each>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="book:write_nolink">
     <xsl:with-param name="refid" select="$refid"/>
     <xsl:with-param name="label" select="$label"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:get_element_index">
  <xsl:param name="data_url"/>
  <xsl:param name="element_name"/>
  <xsl:param name="chapter_type"/>
  <xsl:param name="page_index"/>
  <xsl:choose>
   <xsl:when
     test="contains('preface chapter appendix postface', $element_name)">
    <xsl:call-template name="book:get_chapter_index">
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="chapter_type" select="$chapter_type"/>
     <xsl:with-param name="page_index" select="$page_index"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="book:get_chapter_index">
     <xsl:with-param name="data_url" select="$data_url"/>
     <xsl:with-param name="chapter_type" select="$chapter_type"/>
     <xsl:with-param name="page_index" select="$page_index"/>
    </xsl:call-template>
    <xsl:number level="multiple" count="clause|section"
      format="{$book:clause_index_format}{$book:section_index_format}"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:control_link_by_refid_in_toc_page">
  <xsl:param name="data_url"/>
  <xsl:param name="refid"/>
  <xsl:param name="label"/>
  <xsl:param name="only"/>
  <xsl:variable name="_page"
    select="/xslbook/toc//page[document(@url,/)//*[@id=$refid]]/@url"/>
  <xsl:variable name="_page_index">
   <xsl:for-each select="/xslbook/toc//page">
    <xsl:if test="@url = $_page">
     <xsl:value-of select="position()"/>
    </xsl:if>
   </xsl:for-each>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="string-length($_page) &gt; 0">
    <xsl:for-each select="document($_page,/)">
     <xsl:call-template name="book:control_link_by_refid_in_this_page">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="refid" select="$refid"/>
      <xsl:with-param name="label" select="$label"/>
      <xsl:with-param name="only" select="$only"/>
      <xsl:with-param name="page" select="$_page"/>
      <xsl:with-param name="page_index" select="$_page_index"/>
     </xsl:call-template>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="book:write_nolink">
     <xsl:with-param name="refid" select="$refid"/>
     <xsl:with-param name="label" select="$label"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:write_title_link_by_refid">
  <xsl:param name="refid"/>
  <xsl:param name="index"/>
  <xsl:param name="label"/>
  <xsl:param name="page"/>
  <xsl:param name="chapter_type"/>
  <a class="link title" href="{concat($page,'#',$refid)}">
   <xsl:if test="string-length($index) &gt; 0">
    <span class="index index-in-{$chapter_type}">
     <xsl:value-of select="$index"/>
    </span>
   </xsl:if>
   <xsl:if test="string-length($label) &gt; 0">
    <span class="label">
     <xsl:value-of select="$label"/>
    </span>
   </xsl:if>
  </a>
 </xsl:template>

 <xsl:template name="book:write_link_by_refid">
  <xsl:param name="page"/>
  <xsl:param name="refid"/>
  <xsl:param name="label"/>
  <a class="link" href="{concat($page,'#',$refid)}">
   <xsl:value-of select="$label"/>
  </a>
 </xsl:template>

 <xsl:template name="book:write_link_by_url">
  <xsl:param name="url"/>
  <xsl:param name="label"/>
  <a class="link" href="{$url}">
   <xsl:choose>
    <xsl:when test="string-length($label) &gt; 0">
     <xsl:value-of select="$label"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$url"/>
    </xsl:otherwise>
   </xsl:choose>
  </a>
 </xsl:template>

 <xsl:template name="book:write_nolink">
  <xsl:param name="refid"/>
  <xsl:param name="label"/>
  <xsl:choose>
   <xsl:when test="string-length($label) &gt; 0">
    <span class="nolink" title="{concat($book:popup_of_nolink,': ',$refid)}">
     <xsl:value-of select="$label"/>
    </span>
   </xsl:when>
   <xsl:otherwise>
    <span class="nolink" title="{concat($book:popup_of_nolink,': ',$refid)}">
     <xsl:value-of select="$book:label_of_nolink"/>
    </span>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:get_chapter_type">
  <xsl:value-of select="name(ancestor-or-self::*[contains('preface chapter appendix postface',name())])"/>
 </xsl:template>

</xsl:stylesheet>
