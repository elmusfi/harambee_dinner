<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/xhtml" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">

    <xsl:output method="xhtml" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <!-- Required meta tags -->
                <meta charset="utf-8"/>
                <meta name="viewport"
                    content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

                <!-- Bootstrap CSS -->
                <link rel="stylesheet"
                    href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
                    integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
                    crossorigin="anonymous"/>

                <title>Harambee Dinner Programs</title>
            </head>
            <div class="jumbotron">
                <div class="container">
                    <body>
                        <xsl:apply-templates/>
                        <!-- Optional JavaScript -->
                        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
                        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"/>
                        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"/>
                        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"/>
                    </body>
                </div>
            </div>
        </html>
    </xsl:template>

    <xsl:template match="teiHeader">
        <span style="display:none">
            <xsl:apply-templates/>
            <xsl:value-of select="//fileDesc"/>
            <xsl:value-of select="//encodingDesc"/>
            <xsl:value-of select="//profileDesc"/>
        </span>
    </xsl:template>

    <!-- Transitions -->
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="group/text">
        <hr/>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="head">
        <h3>
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

    <xsl:template match="item">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="div/div/p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="roleName">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="list">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="quote">
        <q>
            <xsl:apply-templates/>
        </q>
    </xsl:template>

    <xsl:template match="div">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Deeper transitions -->
    <xsl:template match="//body/p">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
</xsl:stylesheet>
