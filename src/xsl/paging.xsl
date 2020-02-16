<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:bk="https://github.com/xslet/2020/xslbook"
 xmlns:do="https://github.com/xslet/2020/xsldo"
 xmlns:ut="https://github.com/xslet/2020/xslutil"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <!--**
   The URL of table of contents from `/book@toc` or `/xslbook@toc`. 
 -->
 <xsl:param name="bk:toc_url">
  <xsl:variable name="_url">
   <xsl:value-of select="/book/@toc|/xslbook/@toc"/>
  </xsl:variable>
  <xsl:choose>
   <xsl:when test="contains($_url, '#')">
    <xsl:value-of select="substring-before($_url, '#')"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$_url"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:param>

 <!--**
   The index of the current page among pages contained in table of contents.
 -->
 <xsl:param name="bk:page_index">
  <xsl:call-template name="bk:get_page_index"/>
 </xsl:param>

 <!--**
  Get the index of the current page in pages among pages conteined in table of contents.
 -->
 <xsl:template name="bk:get_page_index">
  <xsl:if test="string-length($bk:toc_url) &gt; 0">
   <xsl:variable name="_index">
    <xsl:if test="system-property('xsl:vendor') = 'Transformiix'">
     <xsl:call-template name="bk:_get_page_index_by_gid"/>
    </xsl:if>
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
  <xsl:variable name="_current_gid" select="generate-id(/)"/>
  <xsl:for-each select="document($bk:toc_url, /)">
   <xsl:for-each select="/book/toc[1]|/xslbook/toc[1]">
    <xsl:for-each select=".//page">
     <xsl:if test="generate-id(document(@href, /)) = $_current_gid">
      <xsl:value-of select="position()"/>
     </xsl:if>
    </xsl:for-each>
   </xsl:for-each>
  </xsl:for-each>
 </xsl:template>

 <xsl:template name="bk:_get_page_index_by_titles">
  <xsl:variable name="_current_titles">
   <xsl:apply-templates select="//title"/>
  </xsl:variable>
  <xsl:for-each select="document($bk:toc_url, /)">
   <xsl:for-each select="/book/toc[1]|/xslbook/toc[1]">
    <xsl:for-each select=".//page">
     <xsl:variable name="_titles">
      <xsl:apply-templates select="document(@href, /)//title"/>
     </xsl:variable>
     <xsl:if test="$_titles = $_current_titles">
      <xsl:value-of select="position()"/>
     </xsl:if>
    </xsl:for-each>
   </xsl:for-each>
  </xsl:for-each>
 </xsl:template>

 <xsl:param name="bk:page_url">
  <xsl:for-each select="document($bk:toc_url,/)">
   <xsl:for-each select="/book/toc[1]|/xslbook/toc[1]">
    <xsl:value-of select="(.//page)[position() = $bk:page_index]/@href"/>
   </xsl:for-each>
  </xsl:for-each>
 </xsl:param>

 <xsl:param name="bk:prev_page_url">
  <xsl:for-each select="document($bk:toc_url,/)">
   <xsl:for-each select="/book/toc[1]|/xslbook/toc[1]">
    <xsl:value-of select="(.//page)[position() = $bk:page_index - 1]/@href"/>
   </xsl:for-each>
  </xsl:for-each>
 </xsl:param>

 <xsl:param name="bk:next_page_url">
  <xsl:for-each select="document($bk:toc_url,/)">
   <xsl:for-each select="/book/toc[1]|/xslbook/toc[1]">
    <xsl:value-of select="(.//page)[position() = $bk:page_index + 1]/@href"/>
   </xsl:for-each>
  </xsl:for-each>
 </xsl:param>

 <xsl:template name="bk:print_navi">
  <xsl:if test="string-length($bk:toc_url) &gt; 0">
   <nav class="navi">
    <xsl:call-template name="bk:_print_navi_prev"/>
    <xsl:call-template name="bk:_print_navi_next"/>
    <xsl:call-template name="bk:_print_navi_toc"/>
   </nav>
  </xsl:if>
 </xsl:template>

 <xsl:template name="bk:_print_navi_prev">
  <span class="navi-page navi-prev">
   <xsl:choose>
    <xsl:when test="string-length($bk:prev_page_url) = 0">
     <a class="disabled">
      <xsl:value-of select="$bk:label_navi_prev"/>
     </a>
    </xsl:when>
    <xsl:otherwise>
     <a href="{$bk:prev_page_url}">
      <xsl:value-of select="$bk:label_navi_prev"/>
     </a>
    </xsl:otherwise>
   </xsl:choose>
  </span>
 </xsl:template>

 <xsl:template name="bk:_print_navi_next">
  <span class="navi-page navi-next">
   <xsl:choose>
    <xsl:when test="string-length($bk:next_page_url) = 0">
     <a class="disabled">
      <xsl:value-of select="$bk:label_navi_next"/>
     </a>
    </xsl:when>
    <xsl:otherwise>
     <a href="{$bk:next_page_url}">
      <xsl:value-of select="$bk:label_navi_next"/>
     </a>
    </xsl:otherwise>
   </xsl:choose>
  </span>
 </xsl:template>

 <xsl:template name="bk:_print_navi_toc">
  <span class="navi-page navi-toc">
   <a href="{$bk:toc_url}">
    <xsl:value-of select="$bk:label_navi_toc"/>
   </a>
  </span>
 </xsl:template>

</xsl:stylesheet>
