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
    
    
    <xsl:variable name="xint" select="100"/>
    <xsl:variable name="ystretch" select="-25"/>
    <xsl:variable name="names" select="10"/>
    
    <xsl:template match="/">
        <xsl:variable name="text" select="//TEI/text"/>
        
        <svg viewBox="0 0 400 -300">
            
            <g transform="translate(50, 500)">
                <xsl:for-each select="//div[@type='menu']//item[.!='Beverages' and .!='Dessert' and .!='Water' and .!='Coffee' and .!='Tea' and .!='Decaf/Tea'] ! lower-case(.) => distinct-values()">   
                    <xsl:sort select="$text//div[@type='menu']//item[. ! lower-case(.) = current()] => count()"  order="descending"/>
                    <xsl:comment><xsl:value-of select="current()"/></xsl:comment>
                    <xsl:if test="position() lt 11">
                        <xsl:variable name="xlabel" select="((position()-1) * $xint) + (.5 * $xint)"/>
                        <g id="{translate(current(), ' ', '_')}">
                            <xsl:variable name="year" select="$text//div[@type='menu']//item[. ! lower-case(.) = current()]/preceding::div[@type='frontPage']//p[1]/date/@when ! tokenize(string(), '-')[1]"/>
                            <xsl:variable name="ypos" select="$ystretch * count($text//div[@type='menu']//item[lower-case(.)=current()])"/>
                            <xsl:comment><xsl:for-each select="$year">
                                <text x="{$xlabel}" y="{$ypos - (7 * position())}" stroke="#00000" style="text-anchor: middle" font-size="7" font-family="sans-serif"><xsl:value-of select="."/></text>
                            </xsl:for-each></xsl:comment>
                            <xsl:choose>
                                <xsl:when test="$text//div[@type='menu']//item[lower-case(.)=current()][1] ! tokenize(string(), ' ')  => distinct-values() => count() gt 1">
                                    <xsl:for-each select="$text//div[@type='menu']//item[lower-case(.)=current()][1] ! tokenize(string(), ' ') => distinct-values()"><text x="{$xlabel}" y="{20 + 15*(position() - 1)}" fill="#000000"  font-weight="bold" style="text-anchor: middle" font-size="10" font-family="Georgia"><xsl:value-of select="."/></text></xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <text x="{$xlabel}" y="20" fill="#000000"  font-weight="bold" style="text-anchor: middle" font-size="10" font-family="Georgia"><xsl:value-of select="($text//div[@type='menu']//item[lower-case(.)=current()])[1]"/></text>
                                </xsl:otherwise>
                            </xsl:choose>
                            <line x1="{$xlabel}" y1="0" x2="{$xlabel}" y2="{$ypos}" stroke-width="40" stroke="#F7D723"/>
                            <text x="{$xlabel}" y="{$ypos - 10}" fill="black" font-weight="bold" font-size="20" font-family="Georgia" style="text-anchor: middle"><xsl:value-of select="count($text//div[@type='menu']//item[lower-case(.)=current()])"/></text>
                        </g></xsl:if> 
                </xsl:for-each>
                
                
                
                
                <!-- X axis -->
                <line x1="0" y1="0" x2="{10 * $xint}" y2="0" stroke="#505152"/>
                <!-- Y axis -->
                <line x1="0" y1="0" x2="0" y2="{$ystretch * 10}" stroke="#505152"/>
                <!-- general labels -->
                <text x="{10 * $xint div 2}" y="{10 * $ystretch - 10}" font-family="Georgia" fill="#AD1800" style="text-anchor: middle" font-size="30">10 Most Common Food/Beverage Items Served at Harambee Dinners</text>           
                <text x="{10 * $xint div 2}" y="70" fill="#AD1800" style="text-anchor: middle" font-family="Arial" font-size="20">Food/Beverage Item</text>
                <text x="{($ystretch * 10) div 2}" y="230" fill="#AD1800" style="text-anchor: middle" transform="rotate(90,100,100)" font-family="Arial" font-size="18">Number of Times Served</text>
            </g>
        </svg>
    </xsl:template>
    
    
</xsl:stylesheet>