<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:ut="https://github.com/sttk/xslet/2019/xslutil"
 xmlns:bk="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:param name="bk:toc_url">
  <xsl:choose>
   <xsl:when test="contains(/xslbook/@toc, '#')">
    <xsl:value-of select="substring-before(/xslbook/@toc, '#')"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="/xslbook/@toc"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:param>

 <xsl:param name="bk:page_index">
  <xsl:call-template name="bk:get_page_index"/>
 </xsl:param>

 <xsl:template name="bk:get_page_index">
  <xsl:if test="string-length($bk:toc_url) &gt; 0">
   <xsl:variable name="_index">
    <xsl:choose>
     <xsl:when test="system-property('xsl:vendor') = 'Transformiix'">
      <xsl:call-template name="bk:_get_page_index_by_gid"/>
     </xsl:when>
    </xsl:choose>
   </xsl:variable>
   <xsl:choose>
    <xsl:when test="string-length($_index) &gt; 0">
     <xsl:value-of select="$_index"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="bk:_get_page_index_by_titles"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:if>
 </xsl:template>

 <xsl:template name="bk:_get_page_index_by_gid">
  <xsl:variable name="_this_gid" select="generate-id(/)"/>
  <xsl:for-each select="document($bk:toc_url,/)/xslbook/toc[1]">
   <xsl:for-each select=".//page">
    <xsl:if test="generate-id(document(@href,/)) = $_this_gid">
     <xsl:value-of select="position()"/>
    </xsl:if>
   </xsl:for-each>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="bk:_get_page_index_by_titles">
  <xsl:variable name="_this_titles">
   <xsl:apply-templates select="//title"/>
  </xsl:variable>
  <xsl:for-each select="document($bk:toc_url,/)/xslbook/toc[1]">
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

 <xsl:param name="bk:page_url">
  <xsl:for-each select="document($bk:toc_url,/)/xslbook/toc[1]">
   <xsl:value-of select="(.//page)[position() = $bk:page_index]/@href"/>
  </xsl:for-each>
 </xsl:param>

 <xsl:param name="bk:previous_page_url">
  <xsl:for-each select="document($bk:toc_url,/)/xslbook/toc[1]">
   <xsl:value-of select="(.//page)[position() = $bk:page_index - 1]/@href"/>
  </xsl:for-each>
 </xsl:param>

 <xsl:param name="bk:next_page_url">
  <xsl:for-each select="document($bk:toc_url,/)/xslbook/toc[1]">
   <xsl:value-of select="(.//page)[position() = $bk:page_index + 1]/@href"/>
  </xsl:for-each>
 </xsl:param>

 <xsl:template name="bk:write_navi">
  <xsl:if test="string-length($bk:toc_url) &gt; 0">
   <nav class="navi">
    <span class="go-page to-previous">
     <xsl:choose>
      <xsl:when test="string-length($bk:previous_page_url) = 0">
       <a class="link disabled">
        <xsl:value-of select="$bk:default_navi_prev"/>
       </a>
      </xsl:when>
      <xsl:otherwise>
       <a class="link" href="{$bk:previous_page_url}">
        <xsl:value-of select="$bk:default_navi_prev"/>
       </a>
      </xsl:otherwise>
     </xsl:choose>
    </span>
    <span class="go-page to-toc">
     <a class="link" href="{$bk:toc_url}">
      <xsl:value-of select="$bk:default_navi_toc"/>
     </a>
    </span>
    <span class="go-page to-next">
     <xsl:choose>
      <xsl:when test="string-length($bk:next_page_url) = 0">
       <a class="link disabled">
        <xsl:value-of select="$bk:default_navi_next"/>
       </a>
      </xsl:when>
      <xsl:otherwise>
       <a class="link" href="{$bk:next_page_url}">
        <xsl:value-of select="$bk:default_navi_next"/>
       </a>
      </xsl:otherwise>
     </xsl:choose>
    </span>
   </nav>
  </xsl:if>
 </xsl:template>

 <xsl:template name="bk:write_navi_header">
  <xsl:call-template name="bk:write_navi"/>
 </xsl:template>

 <xsl:template name="bk:write_navi_footer">
  <xsl:call-template name="bk:write_navi"/>
 </xsl:template>

 <xsl:template name="bk:count_until_prev_page">
  <xsl:param name="chapter_type"/>
  <xsl:param name="page_index" select="$bk:page_index"/>
  <xsl:choose>
   <xsl:when test="string-length($bk:toc_url) &gt; 0">
    <xsl:for-each select="document($bk:toc_url,/)/xslbook/toc[1]">
     <xsl:value-of select="count(document((.//page)[position() &lt; $page_index]/@href, /)/xslbook/*[local-name() = $chapter_type])"/>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="0"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
