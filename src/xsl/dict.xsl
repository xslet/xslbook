<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
 xmlns:book="https://github.com/sttk/xslet/2019/xslbook"
 xmlns:util="https://github.com/sttk/xslet/2019/util"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="dict">
  <xsl:param name="data_url"/>
  <xsl:choose>
   <xsl:when test="boolean(@type)">
    <xsl:call-template name="book:dict_with_style_type">
     <xsl:with-param name="data_url" select="$data_url"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="book:dict_with_mark">
     <xsl:with-param name="data_url" select="$data_url"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template name="book:dict_with_mark">
  <xsl:param name="data_url"/>
  <xsl:variable name="_mark" select="@mark"/>
  <xsl:variable name="_start">
   <xsl:choose>
    <xsl:when test="boolean(@start)">
     <xsl:value-of select="@start"/>
    </xsl:when>
    <xsl:otherwise>1</xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_sep">
   <xsl:choose>
    <xsl:when test="boolean(@separator)">
     <xsl:value-of select="@separator"/>
    </xsl:when>
   </xsl:choose>
  </xsl:variable>
  <ul class="dict" data-mark="{$_mark}" start="{$_start}">
   <xsl:call-template name="book:set_id"/>
   <xsl:apply-templates select="item">
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="separator" select="$_sep"/>
    <xsl:with-param name="mark" select="$_mark"/>
   </xsl:apply-templates>
  </ul>
 </xsl:template>

 <xsl:template match="dict[not(boolean(@type))]//item">
  <xsl:param name="data_url"/>
  <xsl:param name="separator"/>
  <xsl:param name="mark"/>
  <xsl:variable name="_index">
   <xsl:number level="multiple" count="item" format="{$mark}"/>
  </xsl:variable>
  <li class="item" data-index="{$_index}">
   <xsl:call-template name="book:set_id"/>
   <xsl:apply-templates select="title|body">
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="separator" select="$separator"/>
   </xsl:apply-templates>
   <xsl:if test="boolean(item)">
    <ul class="dict" data-mark="{$mark}" start="1">
     <xsl:apply-templates select="item">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="separator" select="$separator"/>
      <xsl:with-param name="mark" select="$mark"/>
     </xsl:apply-templates>
    </ul>
   </xsl:if>
  </li>
 </xsl:template>

 <xsl:template name="book:dict_with_style_type">
  <xsl:param name="data_url"/>
  <xsl:variable name="_type">
   <xsl:choose>
    <xsl:when test="not(substring(@type, 1, 1) = $util:apos and substring(@type, string-length(@type), 1) = $util:apos)">
     <xsl:call-template name="util:validate_string">
      <xsl:with-param name="value" select="normalize-space(@type)"/>
      <xsl:with-param name="forbidden" select="'; '"/>
      <xsl:with-param name="default" select="'disc'"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="@type"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="_sep">
   <xsl:choose>
    <xsl:when test="boolean(@separator)">
     <xsl:value-of select="@separator"/>
    </xsl:when>
   </xsl:choose>
  </xsl:variable>
  <ul class="dict" style="list-style-type:{$_type};">
   <xsl:call-template name="book:set_id"/>
   <xsl:if test="boolean(@start)">
    <xsl:attribute name="start">
     <xsl:value-of select="@start"/>
    </xsl:attribute>
   </xsl:if>
   <xsl:if test="boolean(@reversed)">
    <xsl:attribute name="reversed">
     <xsl:value-of select="@reversed"/>
    </xsl:attribute>
   </xsl:if>
   <xsl:apply-templates select="item">
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="separator" select="$_sep"/>
    <xsl:with-param name="type" select="$_type"/>
   </xsl:apply-templates>
  </ul>
 </xsl:template>

 <xsl:template match="dict[boolean(@type)]//item">
  <xsl:param name="data_url"/>
  <xsl:param name="separator"/>
  <xsl:param name="type"/>
  <li class="item">
   <xsl:call-template name="book:set_id"/>
   <xsl:apply-templates select="title|body">
    <xsl:with-param name="data_url" select="$data_url"/>
    <xsl:with-param name="separator" select="$separator"/>
   </xsl:apply-templates>
   <xsl:if test="boolean(item)">
    <ul class="dict" style="list-style-type:{$type};">
     <xsl:apply-templates select="item">
      <xsl:with-param name="data_url" select="$data_url"/>
      <xsl:with-param name="separator" select="$separator"/>
      <xsl:with-param name="type" select="$type"/>
     </xsl:apply-templates>
    </ul>
   </xsl:if>
  </li>
 </xsl:template>

 <xsl:template match="dict//item/title[1]">
  <xsl:param name="data_url"/>
  <xsl:param name="separator"/>
  <span class="title">
   <xsl:attribute name="data-separator">
    <xsl:value-of select="$separator"/>
   </xsl:attribute>
   <xsl:apply-templates>
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:apply-templates>
  </span>
 </xsl:template>

 <xsl:template match="dict//item/body">
  <xsl:param name="data_url"/>
  <div class="body">
   <xsl:apply-templates>
    <xsl:with-param name="data_url" select="$data_url"/>
   </xsl:apply-templates>
  </div>
 </xsl:template>

</xsl:stylesheet>
