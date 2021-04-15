<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>  
    <!-- How do you have one XSLT file export multiple HTML files? -->
    <!-- Notes to self: 
        Eventually have SVGs for how often certain clubs appear in different events, prevalence of menu items, who gets mentioned/thanked the most, cultures that have been in events, etc.
    -->
    
    <xsl:template match="/">
        <xsl:apply-templates select="//group/text"/>
    </xsl:template>
    
    <xsl:template match="group/text">
        <xsl:variable name="filename" select="@xml:id"/>
        <xsl:result-document method="xhtml" indent="yes" href="{$filename}.html">
            <html>
                <head>
                    <title>Harambee Dinner Program <xsl:value-of select="body/div[1]//p[1]/date/@when ! tokenize(., '-')[1]"/></title>
                    <link type="text/css" href="style.css" rel="stylesheet"/>
                </head>
                <body>
                    <xsl:comment>#include virtual="menu.html" </xsl:comment>
                    <div><xsl:apply-templates/></div>
                    <div class="prognav">
                        <table>
                            <tr>
                                <xsl:if test="preceding-sibling::text[1]"><td><a href="{preceding-sibling::text[1]/@xml:id}.html">⟵ Previous</a></td></xsl:if>
                                <td><a href="programs.html">Back to Programs</a></td>
                                <xsl:if test="following-sibling::text[1]"><td><a href="{following-sibling::text[1]/@xml:id}.html">Next ⟶</a></td></xsl:if>
                            </tr>
                        </table>
                    </div>
                </body></html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="body">
        <h1>Harambee Dinner - <xsl:value-of select="./div[1]//p[1]/date/@when ! tokenize(., '-')[1]"/></h1>
        <table class="progpage"><xsl:apply-templates/></table>
    </xsl:template>
    
    <xsl:template match="p">
        <p><xsl:choose>
            <xsl:when test="persName and matches(., '^M[rs]+\.')">
                <em><xsl:apply-templates/></em>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose></p>
    </xsl:template>
    
    <xsl:template match="persName">
        <xsl:choose>
            <xsl:when test="parent::p and matches(parent::p, '^M[rs]+\.')">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="parent::item and matches(parent::item, '^M[rs]+\.')">
                <!-- This isn't catching Ms. -->
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <em><xsl:apply-templates/></em>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="list">
        <ul><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="item">
        <xsl:choose>
            <xsl:when test="persName and matches(., '^M[rs]+\.')">
                <li><em><xsl:apply-templates/></em></li>
            </xsl:when>
            <xsl:when test="contains(., 'Beverages') or contains(., 'Dessert')">
                <li><h4><xsl:apply-templates/></h4></li>
            </xsl:when>
            <xsl:otherwise>
                <li><xsl:apply-templates/></li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="div[@type]">
        <xsl:choose>
            <xsl:when test="@type = 'page'">
                <tr>
                    <div class="{@type}">
                        <xsl:apply-templates/>
                    </div>
                </tr>
            </xsl:when>
            <xsl:when test="@type='content'">
                <td>
                    <div class="{@type}">
                        <xsl:apply-templates/>
                    </div>
                </td>
            </xsl:when>
            <xsl:otherwise>
                <div class="{@type}">
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
        
        
    </xsl:template>
    
    <xsl:template match="head">
        <h3><xsl:apply-templates/></h3>
    </xsl:template>
    
    <xsl:template match="pb">
        <td><figure class="page"><img src="{@facs}" alt="Harambee Dinner Program {preceding::date[1]/@when ! tokenize(., '-')[1]} Page {@n}."/>
        <figcaption>Page <xsl:value-of select="@n"/></figcaption></figure></td>
    </xsl:template>
    
</xsl:stylesheet>









