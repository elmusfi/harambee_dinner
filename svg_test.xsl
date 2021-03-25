<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:variable name="xint" select="75"/>
    <xsl:variable name="ystretch" select="-25"/>
    <xsl:variable name="names" select="10"/>
    
    <xsl:template match="/">
        <xsl:variable name="text" select="//TEI/text"/>
        
        <svg viewBox="0 0 800 -300">
            
        <g transform="translate(50, 500)">
        <xsl:for-each select="TEI/text//persName ! lower-case(.) => distinct-values()">   
            <xsl:sort select="$text//persName[. ! lower-case(.) = current()] => count()"  order="descending"/>
            <xsl:if test="position() lt 11">
                <xsl:variable name="xlabel" select="((position()-1) * $xint) + (.5 * $xint)"/>
                <g id="{translate(current(), ' ', '_')}">
                    <xsl:variable name="year" select="$text//persName[. ! lower-case(.) = current()]/preceding::div[@type='frontPage']//p[1]/date/@when ! tokenize(string(), '-')[1]"/>
                    <xsl:variable name="ypos" select="$ystretch * count($text//persName[lower-case(.)=current()])"/>
                    <xsl:for-each select="$year">
                        <text x="{$xlabel}" y="{$ypos - (7 * position())}" stroke="#00000" style="text-anchor: middle" font-size="7"><xsl:value-of select="."/></text>
                    </xsl:for-each>
                    
                    <text x="{$xlabel}" y="20" stroke="#000000" style="text-anchor: middle" font-size="10"><xsl:value-of select="($text//persName[lower-case(.)=current()])[1]"/></text>
                        <line x1="{$xlabel}" y1="0" x2="{$xlabel}" y2="{$ypos}" stroke-width="15" stroke="#F7D723"/>
            </g></xsl:if> 
        </xsl:for-each>
        
                
            
                
                    <!-- X axis -->
                    <line x1="0" y1="0" x2="{10 * $xint}" y2="0" stroke="#505152"/>
                    <!-- Y axis -->
                    <line x1="0" y1="0" x2="0" y2="{$ystretch * 10}" stroke="#505152"/>
                    <!-- general labels -->
                    <text x="{10 * $xint div 2}" y="{10 * $ystretch - 10}" stroke="#AD1800" style="text-anchor: middle" font-size="28">10 Most Common Names in Harambee Dinner Programs</text>           
                    <text x="{10 * $xint div 2}" y="70" stroke="#000000" style="text-anchor: middle" font-size="20">Name</text>
                    <text x="-200" y="240" stroke="#000000" style="text-anchor: middle" transform="rotate(90,100,100)" font-size="20">Number of Mentions</text>
                </g>
            </svg>
    </xsl:template>
    
    
</xsl:stylesheet>