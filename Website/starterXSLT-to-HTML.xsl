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
    <!-- Note to self: change div types in XML in order to add divs specific to each of them.
        Do something with the pbs in order to have the page and the text side by side.
        Should org names be bolded or something? 
        h2/h3 for titles of events
        Eventually have SVGs for how often certain clubs appear in different events, prevalence of menu items, who gets mentioned/thanked the most, cultures that have been in events, etc.
    -->
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Harambee Dinner Programs</title>
                <link type="text/css" href="style.css" rel="stylesheet"/>
            </head>
            <body>
                <xsl:comment>#include virtual="menu.html" </xsl:comment>
                <div><xsl:apply-templates select="//TEI/text/group/text/body"/></div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="TEI/text/group/text/body">
        <h1>Harambee Dinner - <xsl:value-of select="./div[1]//p[1]/date/@when ! tokenize(., '-')[1]"/></h1> <!-- This is grabbing all of the first date elements for each individual p element within the first div. How do I narrow it down further? -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="TEI/text//p">
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
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <em><xsl:apply-templates/></em>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI/text//list">
        <ul><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="TEI/text//item">
        <xsl:choose>
            <xsl:when test="persName and matches(., '^M[rs]+\.')">
                <li><em><xsl:apply-templates/></em></li>
            </xsl:when>
            <xsl:otherwise>
                <li><xsl:apply-templates/></li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TEI/text//div[@type='menu']"><div class="menu"><xsl:apply-templates></xsl:apply-templates></div>
    </xsl:template>
    
    <xsl:template match="TEI/text//head">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="TEI/text//pb">
        <figure><img src="{@facs}" alt="Harambee Dinner Program {preceding::date[1]/@when ! tokenize(., '-')[1]} Page {@n}."/></figure>
        <figcaption>Page <xsl:value-of select="@n"/></figcaption>
    </xsl:template>
    
</xsl:stylesheet>









