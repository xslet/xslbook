<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:param name="book:toc_url">
  <xsl:choose>
   <xsl:when test="contains(/xslbook/@toc, '#')">
    <xsl:value-of select="substring-before(/xslbook/@toc, '#')"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="/xslbook/@toc"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:param>

 <xsl:param name="book:page_index">
  <xsl:call-template name="book:get_page_index"/>
 </xsl:param>

 <xsl:template name="book:get_page_index">
  <xsl:if test="string-length($book:toc_url) &gt; 0">
   <xsl:variable name="_index">
    <xsl:choose>
     <xsl:when test="system-property('xsl:vendor') = 'Transformiix'">
      <xsl:call-template name="book:_get_page_index_by_gid"/>
     </xsl:when>
    </xsl:choose>
   </xsl:variable>
   <xsl:choose>
    <xsl:when test="string-length($_index) &gt; 0">
     <xsl:value-of select="$_index"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="book:_get_page_index_by_titles"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:if>
 </xsl:template>

 <xsl:template name="book:_get_page_index_by_gid">
  <xsl:variable name="_this_gid" select="generate-id(/)"/>
  <xsl:for-each select="document($book:toc_url,/)/xslbook/toc[1]">
   <xsl:for-each select=".//page">
    <xsl:if test="generate-id(document(@href,/)) = $_this_gid">
     <xsl:value-of select="position()"/>
    </xsl:if>
   </xsl:for-each>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="book:_get_page_index_by_titles">
  <xsl:variable name="_this_titles">
   <xsl:apply-templates select="//title"/>
  </xsl:variable>
  <xsl:for-each select="document($book:toc_url,/)/xslbook/toc[1]">
   <xsl:for-each select=".//page">
    <xsl:variable name="_titles">
     <xsl:apply-templates select="document(@href,/)//title"/>
    </xsl:variable>
    <xsl:if test="$_titles = $_this_titles">
     <xsl:value-of select="position()"/>
    </xsl:if>
   </xsl:for-each>
  </xsl:for-each>
 </xsl:template>

 <xsl:param name="book:page_url">
  <xsl:for-each select="document($book:toc_url,/)/xslbook/toc[1]">
   <xsl:value-of select="(.//page)[position() = $book:page_index]/@href"/>
  </xsl:for-each>
 </xsl:param>

 <xsl:param name="book:previous_page_url">
  <xsl:for-each select="document($book:toc_url,/)/xslbook/toc[1]">
   <xsl:value-of select="(.//page)[position() = $book:page_index - 1]/@href"/>
  </xsl:for-each>
 </xsl:param>

 <xsl:param name="book:next_page_url">
  <xsl:for-each select="document($book:toc_url,/)/xslbook/toc[1]">
   <xsl:value-of select="(.//page)[position() = $book:page_index + 1]/@href"/>
  </xsl:for-each>
 </xsl:param>

 <xsl:template name="book:control_navi">
  <xsl:if test="string-length($book:toc_url) &gt; 0">
   <xsl:call-template name="book:write_navi"/>
  </xsl:if>
 </xsl:template>

 <xsl:template name="book:write_navi">
  <nav class="navi">
   <xsl:call-template name="book:write_navi_previous"/>
   <xsl:call-template name="book:write_navi_next"/>
   <xsl:call-template name="book:write_navi_toc"/>
  </nav>
 </xsl:template>

 <xsl:template name="book:write_navi_previous">
  <span class="navi-page navi-previous">
   <xsl:choose>
    <xsl:when test="string-length($book:previous_page_url) = 0">
     <a class="disabled">
      <xsl:value-of select="$book:default_navi_prev"/>
     </a>
    </xsl:when>
    <xsl:otherwise>
     <a href="{$book:previous_page_url}">
      <xsl:value-of select="$book:default_navi_prev"/>
     </a>
    </xsl:otherwise>
   </xsl:choose>
  </span>
 </xsl:template>

 <xsl:template name="book:write_navi_next">
  <span class="navi-page navi-next">
   <xsl:choose>
    <xsl:when test="string-length($book:next_page_url) = 0">
     <a class="disabled">
      <xsl:value-of select="$book:default_navi_next"/>
     </a>
    </xsl:when>
    <xsl:otherwise>
     <a href="{$book:next_page_url}">
      <xsl:value-of select="$book:default_navi_next"/>
     </a>
    </xsl:otherwise>
   </xsl:choose>
  </span>
 </xsl:template>

 <xsl:template name="book:write_navi_toc">
  <span class="navi-page navi-toc">
   <a href="{$book:toc_url}">
    <xsl:value-of select="$book:default_navi_toc"/>
   </a>
  </span>
 </xsl:template>

 <xsl:template name="book:count_until_prev_page">
  <xsl:param name="chapter_type"/>
  <xsl:param name="page_index" select="$book:page_index"/>
  <xsl:choose>
   <xsl:when test="string-length($book:toc_url) &gt; 0">
    <xsl:for-each select="document($book:toc_url,/)/xslbook/toc[1]">
     <xsl:value-of select="count(document((.//page)[position() &lt; $page_index]/@href, /)/xslbook/*[name() = $chapter_type])"/>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="0"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
