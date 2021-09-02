<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:gmd="http://www.isotc211.org/2005/gmd" 
xmlns:gco="http://www.isotc211.org/2005/gco" 
xmlns:gmx="http://www.isotc211.org/2005/gmx" 
xmlns:gml="http://www.opengis.net/gml/3.2">
 
  <xsl:output method="html" />

  <!-- Template FICHE -->
  <xsl:template match="/">
    <html lang="fr">
      <head>

        <meta charset="utf-8"/>
        <title>Cartothèque du CEFE</title>
        <meta name="description" content=""/>
        <meta name="author" content=""/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>

        <xsl:comment>
          fileIdentifier = <xsl:value-of select="/gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString"/>
        </xsl:comment>

        <link rel="preconnect" href="https://fonts.googleapis.com"/>
        <link rel="preconnect" href="https://fonts.gstatic.com"  crossorigin="anonymous"/>
        <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@300;400;600&amp;family=Poppins:wght@400&amp;display=swap" rel="stylesheet" /> 

        <link rel="stylesheet" href="../dist/css/normalize.css" />
        <link rel="stylesheet" href="../dist/css/skeleton.css" />
        <link rel="stylesheet" href="../css/cyril.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fancyapps/ui/dist/fancybox.css" />

        <link rel="icon" type="image/png" href="../dist/images/favicon.png"/>

      </head>
      <body>

        <div class="entete">
          <div class="container">
            <header>
              <img src="../images/logo_seul_266px.png" height="60"
                style="float: left; border-radius: 10px; margin: 5px 20px 5px 0; opacity: 0.9;"/>
              <h1>Cartothèque du CEFE</h1>
            </header>
            <nav>
              <a href="../index.html">Accueil</a>
              <a href="../presentation.html">Présentation</a>
              <a href="../liste_cartes.html">Liste des cartes</a>
            </nav>
          </div>
        </div>


        <div class="container">

          <div class="row">
            <h2 class="titre">
              <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString"/>
            </h2>
          </div>

          <div class="row">
            <div class="eight columns">
              <h3>A propos de cette carte</h3>

              <p>
                <span class="element">Résumé</span>
                <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString"/>
              </p>

              <p>
                <span class="element">Echelle</span>
                1/<xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator/gco:Integer"/>
              </p>

              <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date"/>

              <p>
                <span class="element">Auteur(s)</span> 
                <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:credit/gco:CharacterString"/>
              </p>

              <xsl:apply-templates select="/gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement"/>

              <p>
                <span class="element">ID document</span>
                <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString"/>
              </p>
            </div>

            <div class="four columns">
              <script src="https://cdn.jsdelivr.net/npm/@fancyapps/ui/dist/fancybox.umd.js"></script>
              <h3>Aperçu</h3>
              <img>
                <xsl:attribute name="src">
                  <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:graphicOverview[1]/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString"/>
                </xsl:attribute>
                <xsl:attribute name="width">100%</xsl:attribute>
              </img>

              <!--a data-fancybox="single" href="https://cartotheque.cefe.cnrs.fr/datastore/public/JPG/3445_t.jpg">
                <img src="https://cartotheque.cefe.cnrs.fr/datastore/public/JPG/3445_t.jpg" width="100%" />
              </a-->
            </div>
          </div>


          <div class="row">
            <div class="eight columns">
              <h3>Mots clés</h3>
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords"/>
            </div>
            <div class="four columns">
              <h3>Métadonnées format ISO 19139</h3>
              <p>
                <a>
                  <xsl:attribute name="href">../metadata/<xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString"/>.xml</xsl:attribute>
                  <xsl:attribute name="download" />
                  <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString"/>.xml
                </a>
              </p>
            </div>
          </div>

          <div class="row">
            <div class="ten columns">
              <h3>Accès au téléchargement</h3>
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine"/>
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact[1]/gmd:CI_ResponsibleParty"/>
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints"/>
            </div>

          </div>
        </div>

      </body>
    </html>
  </xsl:template>

  <!-- Template DATE -->
  <xsl:template match="gmd:date">
    <p><span class="element">
      <xsl:choose>
        <xsl:when test="gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='publication'">Date de publication</xsl:when>
        <xsl:when test="gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='creation'">Date de création</xsl:when>
      </xsl:choose>
    </span>
    <xsl:value-of select="substring(gmd:CI_Date/gmd:date/gco:Date,1,4)"/></p>
  </xsl:template>

  <!-- Template REALISATION -->
  <xsl:template match="gmd:statement">
    <p>
      <span class="element">Réalisation</span>
      <xsl:value-of select="gco:CharacterString" />
    </p>
  </xsl:template>

  <!-- Template MOTS CLES THESAURUS -->
  <xsl:template match="gmd:descriptiveKeywords">
    <p><span class="element">
      <xsl:choose>
        <xsl:when test="gmd:MD_Keywords/gmd:thesaurusName">
          <xsl:value-of select="gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString" />
        </xsl:when>
        <xsl:otherwise>AUTRE</xsl:otherwise>
      </xsl:choose>
      </span>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="gmd:MD_Keywords/gmd:keyword"/>      
    </p>
  </xsl:template>

  <!-- Template MOT CLE -->
  <xsl:template match="gmd:keyword">
    <span class="button"><xsl:value-of select="gco:CharacterString" /></span>
  </xsl:template>

  <!-- Template LIEN -->

  <xsl:template match="gmd:onLine">
    <p><span class="element">Lien <xsl:value-of select="position()" /></span>
    <xsl:value-of select="gmd:CI_OnlineResource/gmd:description/gco:CharacterString" />
    <xsl:text> </xsl:text>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="gmd:CI_OnlineResource/gmd:linkage/gmd:URL" />
      </xsl:attribute>
      <xsl:value-of select="gmd:CI_OnlineResource/gmd:linkage/gmd:URL" />
    </a></p>
  </xsl:template>

  <!-- Template EMAIL RESPONSABLE -->

  <xsl:template match="gmd:CI_ResponsibleParty">
    <p>
      <span class="element">Contact pour la ressource</span>
      <xsl:value-of select="gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress/gco:CharacterString" />
    </p>
  </xsl:template>

  <!-- Template CONDITIONS UTILISATION -->
  <xsl:template match="gmd:resourceConstraints">
    <p><span class="element">Condition d'utilisation</span>
      <xsl:choose>
        <xsl:when test="gmd:MD_LegalConstraints/gmd:accessConstraints/gmd:MD_RestrictionCode/@codeListValue='intellectualPropertyRights'">droits de propriété intectuelle</xsl:when>
        <xsl:otherwise>autres</xsl:otherwise>
      </xsl:choose>
    </p>
  </xsl:template>

</xsl:stylesheet>