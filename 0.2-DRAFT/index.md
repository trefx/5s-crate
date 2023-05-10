<!-- 
Converted from https://docs.google.com/document/d/1N-3-RkFUFxLl0QozKQ7afhQHs4rKPbHFAzexmgoEF3Y/edit?usp=sharing 
-->

<!-- You have some errors, warnings, or alerts. If you are using reckless mode, turn it off to see inline alerts.
* ERRORs: 9
* WARNINGs: 0
* ALERTS: 9 -->

<p style="color: red; font-weight: bold">>>>>>  gd2md-html alert:  ERRORs: 9; WARNINGs: 0; ALERTS: 9.</p>
<ul style="color: red; font-weight: bold"><li>See top comment block for details on ERRORs and WARNINGs. <li>In the converted Markdown or HTML, search for inline alerts that start with >>>>>  gd2md-html alert:  for specific instances that need correction.</ul>

<p style="color: red; font-weight: bold">Links to alert messages:</p><a href="#gdcalert1">alert1</a>
<a href="#gdcalert2">alert2</a>
<a href="#gdcalert3">alert3</a>
<a href="#gdcalert4">alert4</a>
<a href="#gdcalert5">alert5</a>
<a href="#gdcalert6">alert6</a>
<a href="#gdcalert7">alert7</a>
<a href="#gdcalert8">alert8</a>
<a href="#gdcalert9">alert9</a>

<p style="color: red; font-weight: bold">>>>>> PLEASE check and correct alert issues and delete this message and the inline alerts.<hr></p>



# Five Safes Crate profile

Authors:

1. Stian Soiland-Reyes, The University of Manchester [https://orcid.org/0000-0001-9842-9718](https://orcid.org/0000-0001-9842-9718) 
2. Stuart Wheater


## TRE-FX draft in development 

_(comments and suggestions welcome)_

Permalink: <code>[https://w3id.org/ro/five-safes/0.2-DRAFT](https://w3id.org/ro/five-safes/0.1-DRAFT) (TODO)</code>

This document specifies a draft profile of [RO-Crate](https://w3id.org/ro/crate) for the purpose of [TRE-FX implementation](https://trefx.uk/implementation) of workflow execution in a distributed trusted research environment (TRE). 

_The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 [[RFC2119](https://doi.org/10.17487/RFC2119)] [[RFC8174](https://doi.org/10.17487/RFC8174)] when, and only when, they appear in all capitals, as shown here._


    Note that all references to schema.org types/properties/instances use the prefix `http://schema.org/` (not https) to correspond with the official JSON-LD context.


## Overview

A Five Safes Crate represents a unit of computational access to sensitive information which is managed in accordance with a set of principles conforming to the 5 safe framework.


## Archive serialisation

A compliant Five Safes Crate SHOULD be stored and transferred as an [ZIP archive](http://www.pkware.com/documents/casestudies/APPNOTE.TXT) containing a single [BagIt directory](https://www.researchobject.org/ro-crate/1.1/appendix/implementation-notes.html#combining-with-other-packaging-schemes) (_bag_) of an arbitrary name,_ _which payload _data/_ contains the RO-Crate Metadata File _ro-crate-metadata.json_ and any required data files (e.g. inputs). 

Internally a processing TRE MAY choose to unpack a ZIP file to a local file store, taking necessary security and performance precautions (see 

<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "Security considerations"). Did you generate a TOC with blue links? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[Security considerations](#heading=h.nq7kiyxq67m3)).

The BagIt [payload manifest](https://www.rfc-editor.org/rfc/rfc8493.html#section-2.1.3) [[RFC8493](https://doi.org/10.17487/rfc8493)] MUST be present using sha-512 checksums, and the [tag manifest](https://www.rfc-editor.org/rfc/rfc8493.html#section-2.2.1) SHOULD be included as sha-512 [[FIPS 180-4](https://doi.org/10.6028/NIST.FIPS.180-4)]. Payload and tag manifests using other checksums MAY be included, taking care to exclude _tagmanifest-*_ from their checksums.

Example:


```
query-12389/
  |   bagit.txt                 # MUST indicate BagIt 1.0 or later
  |   bag-info.txt              # As per BagIt specification
  |   manifest-sha512.txt       # As per BagIt specification
  |   tagmanifest-sha512.txt    # As per BagIt specification
  |   fetch.txt                 # Optional, per BagIt Specification
  |   data/                     # Payload: RO-Crate root directory
      |   ro-crate-metadata.json           # RO-Crate Metadata File MUST be present
      |   [payload files and directories]  # 1 or more SHOULD be present
```



### BagIt expectations

The [RO-Crate BagIt expectations](https://www.researchobject.org/ro-crate/1.1/appendix/implementation-notes.html#combining-with-other-packaging-schemes) for _Adding RO-Crate to Bagit _ MUST be followed. The _bag-info.txt_ MUST include a generated _External-Identifier:_ field which SHOULD be a UUID URN [[rfc4122](https://doi.org/10.17487/rfc4122)], e.g.:


```
External-Identifier: urn:uuid:9796155a-fe44-4614-89b8-71945f718ffb
```


The identifier of the _External-Identifier _represents this crate as a request and subsequent response, and SHOULD be freshly generated for each request. It is RECOMMENDED to _not_ modify this identifier as the Five Safes Crate progresses through the distributed TRE processing, unless it is recognized as an previous execution. 

Note that as the ro-crate-metadata.json establishes payload directory data/ as the RO-Crate Root it can only reference files and directories there within, the RO-Crate MUST NOT reference tag files like `../fetch.txt` or other relative paths outside the Bag (see 

<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "Security considerations"). Did you generate a TOC with blue links? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[Security considerations](#heading=h.nq7kiyxq67m3)).


### Zip expectations

The ZIP archive MUST only contain a single top-level entry for the bag directory, identified by the _bagit.txt_ marker. For interoperability in terms of ZIP features, implementations SHOULD follow [guidance for an OSF ZIP Container](https://www.w3.org/publishing/epub32/epub-ocf.html#sec-zip-container-zipreqs) (ignoring _OCF Abstract Container _requirements).


## Metadata file expectations

The RO-Crate Metadata File MUST conform to [RO-Crate 1.2](https://www.google.com/url?q=https://www.researchobject.org/ro-crate/1.2-DRAFT/&sa=D&source=docs&ust=1680005136018780&usg=AOvVaw0olz0R6RJatjMIFdYoAWhW) (or later minor version). The compliant version MUST be declared in the [metadata file descriptor](https://www.researchobject.org/ro-crate/1.2-DRAFT/root-data-entity.html#ro-crate-metadata-file-descriptor): \
 \
`   {`


```
        "@type": "CreativeWork",
        "@id": "ro-crate-metadata.json",
        "about": {"@id": "./"},
        "conformsTo": {"@id": "https://w3id.org/ro/crate/1.2-DRAFT"}
   }
```


The [root data entity](https://www.researchobject.org/ro-crate/1.2-DRAFT/root-data-entity.html#direct-properties-of-the-root-data-entity) of a Five Saves Crate MUST have the @id equal `"./"` (as it is stored within the BagIt ZIP archive). It MAY have an additional <code>[identifier](https://www.researchobject.org/ro-crate/1.1/metadata.html#recommended-identifiers)</code>.


### Profile conformance

Crates conforming to this profile specification SHOULD indicate this on the Root Data Entity using _conformsTo_:


```
   {
        "@id": "./",
        "@type": "Dataset",
        "conformsTo": {"@id": "https://w3id.org/ro/five-safes/0.1-DRAFT"},
        "hasPart": [
        ],
        "mainEntity": {"@id": "https://workflowhub.eu/workflows/289?version=1"},
        "mentions": {"@id": "#query-37252371-c937-43bd-a0a7-3680b48c0538"},
        "sourceOrganization": 
		{"@id": "#project-be6ffb55-4f5a-4c14-b60e-47e0951090c70"}
    },
    {
       "@id": "https://w3id.org/ro/five-safes/0.1-DRAFT",
       "@type": "Profile",
       "name": "Five Saves Crate profile"
    }
```


Note that _licence_ and _datePublished _is not required in a submitted crate, but SHOULD be included for a published crate (see 

<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "Publishing Phase"). Did you generate a TOC with blue links? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[Publishing Phase](#heading=h.856k9eashjmk)).


### Referencing a Workflow Crate

The metadata file MUST reference a [Workflow RO-Crate](https://w3id.org/workflowhub/workflow-ro-crate/1.0) _Dataset _as its _mainEntity_, indirectly indicating the workflow to execute. 

The identifier SHOULD be a permalink or versioned URL (e.g. [https://workflowhub.eu/workflows/289?version=1](https://workflowhub.eu/workflows/289?version=1)) or MAY be a nested directory within the BagIt payload directory (e.g. `"workflow289.1/"`).

**Note**: unlike in the [Workflow Run profile](https://www.researchobject.org/workflow-run-crate/profiles/0.1/workflow_run_crate), the programming language of the workflow and its other metadata are not expressed in this RO-Crate, but within the referenced Workflow RO-Crate. The _programmingLanguage_ inside the Workflow RO-Crate SHOULD be either [https://w3id.org/workflowhub/workflow-ro-crate#cwl](https://w3id.org/workflowhub/workflow-ro-crate#cwl) or [https://w3id.org/workflowhub/workflow-ro-crate#nextflow](https://w3id.org/workflowhub/workflow-ro-crate#nextflow).

See 

<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "security considerations"). Did you generate a TOC with blue links? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[security considerations](#heading=h.nq7kiyxq67m3) for workflow referencing and execution. 


#### Finding the RO-Crate archive

If the identifier is a URI, an URL to the downloadable Workflow RO-Crate ZIP archive SHOULD be included with _distribution_, otherwise clients SHOULD [use Signposting](https://signposting.org/adopters/#workflowhub) to find the link to the RO-Crate by looking for the link with `rel="item" type="application/zip" profile="https://w3id.org/ro/crate"` - for instance:


```
curl -I "https://workflowhub.eu/workflows/289?version=1"

HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8
<https://workflowhub.eu/workflows/289/ro_crate?version=1> ;
      rel="item" ;
      type="application/zip" ;
      profile="https://w3id.org/ro/crate" 
```



#### Example:


```
 {
    "@id": "https://workflowhub.eu/workflows/289?version=1",
    "@type": "Dataset",
    "name": "CWL Protein MD Setup tutorial with mutations",
    "conformsTo": {"@id": "https://w3id.org/workflowhub/workflow-ro-crate/1.0"},
    "distribution": {
      "@id": "https://workflowhub.eu/workflows/289/ro_crate?version=1"}
  },
  {
    "@id": "https://workflowhub.eu/workflows/289/ro_crate?version=1",
    "@type": "DataDownload",
    "conformsTo": {"@id": "https://w3id.org/ro/crate"},
    "encodingFormat": "application/zip"
  }
```


In the above example, the _mainEntity_ points to a _Dataset_ that conforms to the Workflow RO-Crate Profile and references the ZIP download URI using _distribution_, therefore the client can download the workflow directly without needing to follow Signposting headers.


### Requested Workflow Run

The metadata file MUST include a [CreateAction](http://schema.org/CreateAction), which MUST be referenced from _mentions_ of the root entity. The identifier SHOULD be based on a UUID (different from the BagIt External-Identifier).

The CreateAction MUST reference the Workflow Crate using _instrument_.


#### Example:


```
   {
        "@id": "#query-37252371-c937-43bd-a0a7-3680b48c0538",
        "@type": "CreateAction",
        "actionStatus": "http://schema.org/PotentialActionStatus", 
        "agent": {"@id": "https://orcid.org/0000-0001-9842-9718"},
        "instrument": {"@id": "https://workflowhub.eu/workflows/289?version=1"},
        "name": "Execute query 12389 on workflow ",
        "object": [
            {"@id": "input1.txt"}
        ]
    }
```


The 

<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "CreateAction’s actionStatus"). Did you generate a TOC with blue links? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[CreateAction’s actionStatus](#heading=h.uyr0r2dywnt2) will change during execution.


### Requesting Agent

The individual person who is requesting the run MUST be indicated as an _agent_ from the _CreateAction_, which SHOULD have an _affiliation_ to the organisation they are representing for access control purposes.


```
   {
        "@id": "https://orcid.org/0000-0001-9842-9718",
        "@type": "Person",
        "name": "Stian Soiland-Reyes",
        "affiliation": { "@id": "https://ror.org/027m9bs27"},
        "memberOf": [
          {"@id": "#project-be6ffb55-4f5a-4c14-b60e-47e0951090c70"}
        ]
    },
    {
        "@id": "https://ror.org/027m9bs27",
        "@type": "Organization",
        "name": "The University of Manchester"
    },
```


**Note**: The organisation under _affiliation_ is typically the employing organisation, e.g. a university or hospital. Virtual organisations such as research projects MAY additionally be listed using _memberOf_ (see also _Responsible Project_ below).


### Responsible Project

The project that the request is sent on behalf of, typically related to permission to use a TRE, MUST be indicated from the root dataset using _sourceOrganization_ to a _[Project](https://schema.org/Project)_. The responsible project SHOULD be referenced from the requesting agent’s _memberOf_. 

**Note**: The _responsible project_ is not necessarily a [ResearchProject](https://schema.org/ResearchProject) corresponding to a funded grant, but may be more specific studies within a funded project. Various TREs may have different granularity and identifiers for the responsible projects. A project _Grant_ MAY be referenced using [funding](https://schema.org/funding) from the responsible project.

It is RECOMMENDED to include TRE-specific ids under _identifier _(which MAY be an array).  If the identifier is not globally unique (e.g. an integer rather than an UUID or URI), it is RECOMMENDED to add a [repository-specific identifier](https://www.researchobject.org/ro-crate/1.1/appendix/implementation-notes.html#repository-specific-identifiers) and provide the local identifier as _value _of a _PropertyValue_ entity. Multiple repository-specific identifiers MAY be included for different TREs from a single Project entity.

The project MAY indicate the _member_ organisations, in which case one of them SHOULD match the _affiliation_ of the _Requesting Agent _with a _memberOf_ to this project.


```
{"@id": "#project-be6ffb55-4f5a-4c14-b60e-47e0951090c70",
 "@type": "Project",
 "name": "Investigation of cancer (TRE72 project 81)",
 "identifier": [
       {"@id": "_:localid:tre72:project81"}
 ],
 "funding": [
	"@id": "https://gtr.ukri.org/projects?ref=10038961",
 ],
 "member": [
    {"@id": "https://ror.org/027m9bs27"},
    {"@id": "https://ror.org/01ee9ar58"},
 ]
},
{ "@id": "_:localid:tre72:project81",
  "@type": "PropertyValue",
  "name": "tre72",
  "value": "project81"
},
{ "@id": "https://gtr.ukri.org/projects?ref=10038961",
  "@type": "Grant",
  "name": "EOSC4Cancer"
}
```



### Agreement Data

The Agreement data relevant to a Researcher will specify:

- The projects which a researcher is a participate of;

- The data instances which each project is permitted access;

- The analysis types a project is permitted to perform, on each data instance.

- The permitted address to which responses can be sent for that project.


### Inputs


### Requested inputs SHOULD be set on the _CreateAction_ using the _object_ property: \
`{`


```


###         "@id": "#query-37252371-c937-43bd-a0a7-3680b48c0538",


###         "@type": "CreateAction",
        "object": [


###             {"@id": "input1.txt"},


###             {"@id": "#enableFastMode"}


###         ],
        "…": {}
}
```



### Each input MUST have a corresponding data entity, which SHOULD have a _exampleOfWork _to a corresponding FormalParameter:


```


### { "@id": "input1.txt",
  "@type": "File",
  "name": "input1",
  "exampleOfWork": {"#sequence"}
},
{


###   "@id": "#enableFastMode",
  "@type": "PropertyValue",
  "name": "--fast-mode",
  "value": "True",
  "exampleOfWork": {"#fast"}  


### },
{ "@id": "#sequence",
  "@type": "FormalParameter",
  "name": "input-sequence"
},


### { "@id": "#fast",
  "@type": "FormalParameter",
  "name": "fast-mode"
}
```



### Tip: While the [FormalParameter](https://www.researchobject.org/ro-crate/1.1/workflows.html#describing-inputs-and-outputs) SHOULD match the definitions within the Workflow Crate referenced from _mainEntity_, the only requirement from this profile is that their _name_ is programmatically recognized by the workflow engine for binding input parameters of the particular workflow. 


### Outputs


### If the workflow has successfully executed, that is the _CreateAction_ has _actionStatus_ set to _CompletedActionStatus_, the output data entities SHOULD be referenced from the _results _array.


### Output entities MUST be described as in the [Workflow Run Crate profile](https://w3id.org/ro/wfrun/workflow/0.1), with type SHOULD be _File_, _Dataset_, _Collection_, _DigitalDocument _or _PropertyValue_.


### Implementations MAY include the outputs within the Crate BagIt archive, in which case it is RECOMMENDED to use the folder _outputs/_ to avoid conflict with other files in the crate.


```


### {


###         "@id": "#query-37252371-c937-43bd-a0a7-3680b48c0538",


###         "@type": "CreateAction",
        "result": [


###             {"@id": "outputs/table.csv"},


###             {"@id": "outputs/diagrams/"}


###         ],
        "…": {}
},


### {


### "@id": "outputs/qa.csv",


### "@type": "File",


### "encodingFormat": "text/csv",


### "name": "Tabular listing of quality assessment"


### },


### {


### "@id": "outputs/diagrams/",


### "@type": "Dataset",


### "name": "Diagrams of regions of interest"


### }
```



### Tip: Implementations may need to inspect the FormalParameter of the Workflow Crate to propagate a human readable _name_ and _encodingFormat_ file format of the inputs and output.


#### Sensitive data


### Outputs MAY include references to sensitive data that is only accessible from within the TRE or through URIs that require authentication. The requirement for permission SHOULD be indicated by typing the data entity as a [DigitalDocument](https://schema.org/DigitalDocument) that use _hasDigitalDocumentPermission_ to reference the [DigitalDocumentPermission](http://schema.org/DigitalDocumentPermission) entity, typically assigning <code>[http://schema.org/ReadPermission](http://schema.org/ReadPermission) </code>with <em>grantee</em> to only to the <em>Responsible Project</em>.


```


### {


### "@id": "urn:uuid:07b81e0f-7ac4-5428-9940-878b241e2397",


### "@type": "DigitalDocument",


### "encodingFormat": "text/csv",


### "name": "Patient measurement 07b81e0f-7ac4-5428-9940-878b241e2397",


### "hasDigitalDocumentPermission": {"@id": "#permissions-07b81e0f"},


### },


### {	"@id": "#permissions-07b81e0f",


###        "@type": "DigitalDocumentPermission",


###        "permissionType": "http://schema.org/ReadPermission",


###        "grantee": { "@id": "#project-be6ffb55-4f5a-4c14-b60e-47e0951090c70"}
}
```



### Review process

The Five Safes RO-Crate may face several reviews both before and after workflow execution, automated and manual. To record that such review will or has taken place, a series of additional _[Action](https://schema.org/docs/actions.html)_ contextual entities SHOULD be related to the root data entity using _mentions_.

It is RECOMMENDED that the first step after authentication is a syntactic validation step that verifies the RO-Crate validity according to this profile and system expectations. This step SHOULD remove _mentions_ references to any end-user-provided [AssessAction](http://schema.org/AssessAction) (as defined in this profile) from the submitted crate, in order to ensure only assessment endorsements by the particular TRE are considered in the subsequent internal processing.

Assessment actions SHOULD indicate an 

<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "actionStatus"). Did you generate a TOC with blue links? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[actionStatus](#heading=h.byrges19zp0h)_ _to reflect the outcome or pending nature of the assessment. Each assessment SHOULD have the root data entity (typically `{"@id": "./"}`) listed under _object,_ and MAY include additional entities that were assessed.

The phase of the review process is indicated using subclasses of _Action_ and more accurately with _additionalType _using terms from the Safe Haven Provenance ([SHP](https://w3id.org/shp)) ontology`.`

The _name_ of the action MUST provide a human readable name of the type of check and its outcome, but SHOULD NOT be consulted by software for decision making (rather they should check _actionStatus _and _additionalType_).

Each completed action SHOULD have a timestamp using _endTime_ that follow the ISO-8601 syntax of [RFC 3339](https://doi.org/10.17487/RFC3339) (including timezone or Z). _startTime_ MAY be included for active, failed and completed actions.

The main actor performing the assessment SHOULD be listed under _agent_ and refer to either a _Organization_ (e.g. an TRE helpdesk), _Person_ (manual check) or a [SoftwareApplication](https://schema.org/SoftwareApplication) (automated check). A SoftwareApplication acting on behalf of a TRE MUST include a reference to the TRE _Organization_ using _provider_. There may be multiple actors appearing as _agent_ for different actions, each of which should be listed as contextual entities with at least _name_.


```
{ "@id": "https://tre72.example.com/#crate-validator",
  "@type": "SoftwareApplication",
  "name": "RO-Crate validator at TRE72",
  "provider": {"@id": "https://tre72.example.com/"}
},
{ "@id": "https://tre72.example.com/",
  "@type": "Organization",
  "name": "TRE 72 trusted research environment at The University of Manchester",
  "parentOrganization": {"@id": "https://ror.org/027m9bs27"}
}
```



#### Check phase

Before any further processing, the content of a submitted crate SHOULD be checked for integrity and completeness against the BagIt payload manifest and tag manifest, considering at least the SHA-512 algorithm. This phase MAY also check any cryptographic signatures.  \
Example: 


```
{ "@id": "#check-f33fe90c-0c22-4c72-b299-de509028410e",
  "type": "AssessAction",
  "additionalType": {"@id": "https://w3id.org/shp#CheckValue"},
  "name": "BagIt checksum of Crate: OK",
  "endTime": "2023-04-18T12:11:45+01:00",
  "object": {"@id": "./"},
  "instrument": {
      "@id": "https://www.iana.org/assignments/named-information#sha-512"},
  "agent": {"@id": "#validator-a4a66c63-2fe0-4c57-830d-268a40718313"},
  "actionStatus": "http://schema.org/CompletedActionStatus"
},
{ "@id": "https://www.iana.org/assignments/named-information#sha-512",
  "@type": "DefinedTerm",
  "name": "sha-512 algorithm"
}
```



    **Note** that subsequent modifications to the submitted crate by the TRE will necessarily mean checksums become out of date. It is RECOMMENDED to update the BagIt manifest following crate modifications if further TRE phases require checksum (e.g. after network transfer), however any subsequent internal checksum validations SHOULD NOT be recorded as an AssessAction. Checksums of the final crate MUST be updated by the _Publishing phase _and recorded accordingly.

The check phase MAY perform any additional file-level security checks required by the particular TRE, e.g. maximum file size of crate, valid characters in filenames or use of symbolic links.


#### Validation phase

A crate that has been validated according to RO-Crate specifications and this profile SHOULD _mention_ an _AssessAction _which _instrument_ refers to the profile entity, and an _additionalType _referring to `https://w3id.org/shp#ValidationCheck. `Example:

`{ "@id": "#validate-1146f640-819e-4c86-b029-b763a0040896", \
  "type": "AssessAction", \
  "additionalType": {"@id": "https://w3id.org/shp#ValidationCheck"}, \
  "name": "Validation against Five Safes Crate profile: approved", \
  "startTime": "2023-04-18T12:11:46+01:00", \
  "endTime": "2023-04-18T12:11:49+01:00", \
  "object": {"@id": "./"}, \
  "instrument": {"@id": "https://w3id.org/ro/five-safes/0.1-DRAFT"}, \
  "agent": {"@id": "#validator-a4a66c63-2fe0-4c57-830d-268a40718313"}, \
  "actionStatus": "http://schema.org/CompletedActionStatus" \
`}

The validation phase MAY perform any additional syntactic or semantic checks required by the particular TRE and workflow, e.g. correspondence between provided and expected input parameters, in which case this should be reflected by adding such entities to _object_ (checked) and _instrument_ (expected) as arrays.


#### Workflow retrieval phase

The referenced workflow crate may be retrieved by the TRE before Sign-off or Workflow Execution, potentially using a local proxy (see 

<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "Finding the RO-Crate archive"). Did you generate a TOC with blue links? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[Finding the RO-Crate archive](#heading=h.svx3e0hfb6k9) and 

<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "Security considerations"). Did you generate a TOC with blue links? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[Security considerations](#heading=h.nq7kiyxq67m3)). In this case, the retrieval SHOULD be indicated by a [DowloadAction](https://schema.org/DownloadAction) with the Workflow RO-Crate’s distribution as _object _(indicating the URL that was downloaded from, potentially following Signposting). 

Implementations MAY choose to unpack and add the Workflow Crate folder to the Bagit, in which case it SHOULD be indicated as an additional data entity referenced as _result_, which reference the _mainEntity_ from _sameAs_ and the download location in _distribution_. 

Example:


```
{ "@id": "#download-8b51bf57-6b29-44da-b24b-638c8df91639",
  "type": "DownloadAction",
  "name": "Downloaded workflow RO-Crate via proxy",
  "startTime": "2023-04-18T12:11:50+01:00",
  "endTime": "2023-04-18T12:11:52+01:00",
  "object": {"@id": "https://workflowhub.eu/workflows/289/ro_crate?version=1"},
  "result": {"@id": "workflow/289/"},
  "agent": {"@id": "http://proxy.example.com/"},
  "actionStatus": "http://schema.org/CompletedActionStatus"
},
{
  "@id": "workflow/289/",
  "sameAs": { "@id": "https://workflowhub.eu/workflows/289?version=1" },
  "@type": "Dataset",
  "name": "CWL Protein MD Setup tutorial with mutations",
  "conformsTo": {"@id": "https://w3id.org/workflowhub/workflow-ro-crate/1.0"},
  "distribution": {
    "@id": "https://workflowhub.eu/workflows/289/ro_crate?version=1"}
}
```



#### Sign-off phase

Before executing a Five Safes Crate, the TRE SHOULD check if the requesting agent is permitted to execute the particular workflow on behalf of the responsible project. This SHOULD include checks against the Agreement policy data maintained by the TRE. This may be a manual and/or automated check, as indicated by _agent_. The _object_ SHOULD additionally reference the workflow and responsible project (unless these were not part of the sign-off checks).


```
{ "@id": "#signoff-3b741265-cfef-49ea-8138-a2fa149bf2f0",
  "type": "AssessAction",
  "additionalType": {"@id": "https://w3id.org/shp#SignOff"},
  "name": "Sign-off of execution according to Agreement policy: approved",
  "endTime": "2023-04-19T17:15:12+01:00",
  "object": [
      {"@id": "./"}, 
      {"@id": "https://workflowhub.eu/workflows/289?version=1"},
      {"#project-be6ffb55-4f5a-4c14-b60e-47e0951090c70},
 ],
  "instrument": {"@id": "https://tre72.example.com/agreement-policy/81"},
  "agent": {"@id": "https://orcid.org/0000-0002-1825-0097"},
  "actionStatus": "http://schema.org/CompletedActionStatus"
},
```


`{ "@id": "https://tre72.example.com/agreement-policy/81", \
  "@type": "CreativeWork", \
  "name": "Agreement policy for TRE72 for project 81", \
`},


#### Workflow execution phase

In this phase, the approved workflow execution is performed within the TRE. The _CreateAction_ of the workflow execution will its _actionStatus_ and acquire a _startTime _and _endTime_.

When the execution is in CompletedActionStatus or FailedActionStatus, the crate SHOULD also follow the [Provenance Crate](https://w3id.org/ro/wfrun/provenance/0.1) profile, e.g. the workflow outputs data entities will be listed as _result._


##### Execution states

The states of the Five Safes Crate is indicated by the _actionStatus_ of this main action:



* [http://schema.org/PotentialActionStatus](http://schema.org/PotentialActionStatus) – The request is queued to be executed
* [http://schema.org/ActiveActionStatus](http://schema.org/ActiveActionStatus) – The request is currently executing
* [http://schema.org/CompletedActionStatus](http://schema.org/CompletedActionStatus) – The request has finished successfully
* [http://schema.org/FailedActionStatus](http://schema.org/FailedActionStatus) – The request failed, but may have partial results or logs.  


##### Example


```
   {
        "@id": "#query-37252371-c937-43bd-a0a7-3680b48c0538",
        "@type": "CreateAction",
        "actionStatus": "http://schema.org/CompletetedActionStatus", 
        "startTime": "2023-04-18T13:52:19+01:00",
        "endTime": "2023-04-18T14:00:19+01:00",
        "agent": {"@id": "https://orcid.org/0000-0001-9842-9718"},
        "instrument": {"@id": "https://workflowhub.eu/workflows/289?version=1"},
        "name": "Execute query 12389 on workflow ",
        "object": [
            {"@id": "input1.txt"}
        ],
        "result": [
            { "@id": "result/matches.txt"}
            { "@id": "result/stats.txt"}
        ]
    }
```


Note that even if the workflow execution action is in CompletetedActionStatus, two additional phases are required to pass before the Five Safe Crate can be considered “finished”, see the following subsections.


#### Disclosure phase

Before workflow results are returned from the TRE, a disclosure check SHOULD be performed, e.g. to verify the workflow execution has not revealed sensitive data. Depending on the workflow and TRE data this may be automated and/or manual as indicated by _agent_.

In the example below, a person has been assigned, while the _actionStatus_ indicates the disclosure check is pending (_startTime_ in this case indicating predicted waiting time into the future). \
 \
`{ "@id": "#disclosure-b16c1f0a-ae7f-4582-9b28-7d9df3313e27", \
  "type": "AssessAction", \
  "additionalType": {"@id": "https://w3id.org/shp#DisclosureCheck"}, \
  "name": "Disclosure check of workflow results: pending (estimate: 1 week)", \
  "startTime": "2023-04-25T16:00:00+01:00", \
  "object": {"@id": "./"}, \
  "agent": {"@id": "https://orcid.org/0000-0002-1825-0097"}, \
  "actionStatus": "http://schema.org/PotentialActionStatus" \
`}

If a crate fails the disclosure phase, its content such as workflow results MUST NOT be included in the returned crate returned to the user. Likewise, its workflow execution _CreateAction_ and corresponding output data entities SHOULD be removed from the metadata file.


#### Publishing phase

Before a disclosure-approved Five Saves Crate is published to the requesting user (or archived in a repository), some housekeeping tasks are to be completed.

The root data entity’s _datePublished_ SHOULD be updated to the time the manifest is last written. The _publisher_ SHOULD be updated to reflect the executing TRE. The _mentions_ MUST be expanded to include all the _AssessAction_s recorded by the TRE. _hasPart_ MUST include (possibly through intermediate folders as _Dataset) _any _result_ data entities now referred to from the workflow execution’s _CreateAction_. 

The _[licence](https://www.researchobject.org/ro-crate/1.1/contextual-entities.html#licensing-access-control-and-copyright)_ SHOULD be included to describe the licence of the workflow output data, either an open licence such as Creative Commons, or a restrictive (typically TRE-specific) conditions of access.


```
{
        "@id": "./",
        "@type": "Dataset",
        "conformsTo": {"@id": "https://w3id.org/ro/five-safes/0.1-DRAFT"},
        "datePublisher": "2023-04-29T11:01:04+01:00",
        "publisher": {"@id": "https://tre72.example.com/"},
        "licence": {"@id": "http://spdx.org/licenses/CC-BY-4.0"},
        "hasPart": […],
        "mainEntity": {"@id": "https://workflowhub.eu/workflows/289?version=1"},
        "mentions": […],
        "sourceOrganization": 
		{"@id": "#project-be6ffb55-4f5a-4c14-b60e-47e0951090c70"}
    }
},
{ "@id": "https://spdx.org/licenses/CC-BY-4.0",
  "@type": "CreativeWork",
  "name": "Creative Commons Attribution 4.0 International", 
  "identifier": "CC-BY-4.0"
}
```


TRE implementations MAY additionally [record changes](https://www.researchobject.org/ro-crate/1.1/provenance.html#recording-changes-to-ro-crates) to the RO-Crate as it has progressed through the execution, by associating a _CreateAction_ and subsequent _UpdateAction_ to the root data entity as _object_.

Following the final update of the RO-Crate Metadata file and content, the BagIt payload manifests and tag manifests MUST be updated (as a minimum because the _ro-crate-metadata.json_ has been modified). The _result_ entity is NOT recorded, as `../manifest-sha512.txt` would have escaped the RO-Crate root. The agent SHOULD delete manifest files it can’t re-generate. After the checksum calculation, the TRE SHOULD not do any further changes to the crate or BagIt files. 


```
{ "@id": "#bagit-ce785c0b-c988-4043-8cbd-1489dcebc14f",
  "type": "AssessAction",
  "startTime": "2023-04-29T12:12:25+01:00",
  "additionalType": {"@id": "https://w3id.org/shp#GenerateCheckValue"},
  "name": "BagIt manifests of Crate updated",
  "object": {"@id": "./"},
  "instrument": {
     "@id": "https://www.iana.org/assignments/named-information#sha-512"},
  "agent": {"@id": "#validator-a4a66c63-2fe0-4c57-830d-268a40718313"},
  "actionStatus": "http://schema.org/CompletedActionStatus"
},
{ "@id": "https://www.iana.org/assignments/named-information#sha-512",
  "@type": "DefinedTerm",
  "name": "sha-512 algorithm"
}
```



    **Note: **This action must be written to the_ _RO-Crate Metadata File _before _calculating the payload manifest, and therefore can’t include the correct _endTime_. The _actionStatus_ should nevertheless reflect the status as if it has already completed. Likewise, the payload manifest must be calculated before updating the tag manifest, as it includes the checksum of the payload manifest.


#### Receiving phase 

Clients receiving a Five-Safe Crate SHOULD check the BagIt manifest checksums similar to the _Check phase_, as well as the status of all the actions specified in this profile before further processing. 

It is NOT sufficient for clients to check the publishing AssessAction, as TRE implementations are permitted to expose partial crates which have failed approval phases or which are in pending/execution state.

Clients MAY add additional post-processing data and/or metadata not specified in this profile to the crate (e.g. [ReceiveAction](https://schema.org/ReceiveAction)), in which case they SHOULD maintain the BagIt manifests accordingly. Manifest checksums can be used to detect accidental local changes in post-processing.


## Security considerations

It is RECOMMENDED that implementers apply strong access control before accepting a Five Safes Crate. 

Allowing execution of any Workflow Crate effectively allows execution of arbitrary code. It is RECOMMENDED to check against a list of pre-approved workflows (see 

<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: undefined internal link (link text: "Sign-off phase"). Did you generate a TOC with blue links? </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>

[Sign-off phase](#heading=h.5nrqbjfi2n4g)), e.g. using file checksums or cryptographic signatures. 

Clients parsing and unpacking ZIP files, JSON metadata, workflow definitions and BagIt manifests SHOULD apply reasonable security measures to limit the possibility of an attacker to consume excessive disk, CPU or memory resources, as well as escaping any file directory or execution container jails. For instance, clients should check for invalid file path characters, relative paths or symbolic links escaping the crate, as well guard against _zip bomb_ attacks.

Pre-approved workflows could be exploited by a malicious attacker if they, the workflow engine or their tools themselves have security vulnerabilities, e.g. by using hand-crafted input parameters that by-passes command line escapes. Workflow executions are not guaranteed to complete in a given timescale; sufficient timeouts and resource usage restrictions SHOULD therefore be applied by the workflow engine.

It is currently out of scope for this specification how to verify that Five Saves Crate was requested by the given person, or how to verify if the person has access to a particular TRE according to their Agreement policies. It is therefore RECOMMENDED that implementers check authentication and authorization of a submitted query and use strong encryption. Implementers SHOULD check that the @id and affiliation of the _Requesting Agent_ and _Responsible Project c_orresponds to the authentication, and MAY inject/overwrite client-submitted data.

Malicious clients submitting a Five Safes Crate may have included additional entities, properties and types, which may cause security concerns in an implementation. Implementers SHOULD sanity check inputs, including ensuring that all paths are relative within the bag or absolute URIs, and MUST remove references to any client-submitted _AssessAction_s, as these could be used to bypass the TRE compliance process.

Malicious clients MAY attempt to reference URLs or IP addresses that are only accessible within a TRE. Implementers MUST perform any URL downloads (such as Workflow RO-Crates or container images) in a way that does not access the secured TRE network, e.g. from a _Demilitarized Zone _(DMZ) with a network firewall restricting access to the TRE, or through a proxying repository controlled by TRE administrators.

As an executed Five Saves Crate may be intended for publishing (possibly following an embargo period), it SHOULD NOT include sensitive data or security tokens within the metadata file or the BagIt archive (e.g. in configuration or log files); TREs SHOULD verify this in the _Disclosure Phase._ It is RECOMMENDED to use keychain services or time-limited security access tokens that can be assured to be expired before the Crate is published.

The crate MAY include references (e.g. S3 URIs) to sensitive data, in which case the implementation and executed workflow SHOULD protect against divulging sensitive information (directly or indirectly) in the _File_ identifiers, use UUID v5 hashing [[RFC4122](https://doi.org/10.17487/rfc4122)]  to hide sensitive identifiers.<code> <strong>Note</strong></code>: predicable identifiers like <code>patient-456</code> would still be vulnerable in such hashing due to iteration attacks.<code> \
</code>


## Media type and profiles

When transferring a HTTP Five Safes Crate using HTTP, implementations SHOULD use the following HTTP headers for content-type and profile:

`Content-Type: application/zip \
Link: &lt;https://w3id.org/ro/crate>; rel="profile"` \


HTML landing pages that reference a Five Safes Crate SHOULD include [Signposting](https://signposting.org/) using HTTP `Link `headers that refer to the Crate’s ZIP download and the RO-Crate profile:

`Link: &lt;https://example.com/query-12389.zip>; rel="item", type="application/zip" \
Link: &lt;https://w3id.org/ro/crate>; rel="profile"; type="application/zip"; \
   anchor="https://example.com/query-12389.zip"` \


Implementations MAY also provide direct public access to the RO-Crate metadata file, in which case they SHOULD follow the [RO-Crate media type recommendations](https://www.researchobject.org/ro-crate/1.2-DRAFT/appendix/jsonld.html#ro-crate-json-ld-media-type) for JSON-LD, in which case it is RECOMMENDED to convert the metadata file to [Detached RO-Crate](https://www.researchobject.org/ro-crate/1.2-DRAFT/appendix/relative-uris.html#converting-from-attached-to-detached-ro-crate) by establishing a [base URI](https://www.researchobject.org/ro-crate/1.1/appendix/relative-uris.html#establishing-a-base-uri-inside-a-zip-file) based on the BagIt `External-Identifier` UUID (e.g. `arcp://uuid,9796155a-fe44-4614-89b8-71945f718ffb/`).


## References

[FIPS 180-4] Secure Hash Standard (SHS) [https://doi.org/10.6028/NIST.FIPS.180-4](https://doi.org/10.6028/NIST.FIPS.180-4) 


    [Provenance Run Crate] Provenance Run Crate profile [https://w3id.org/ro/wfrun/provenance/0.1](https://w3id.org/ro/wfrun/provenance/0.1) 


    [RFC2119] Key words for use in RFCs to Indicate Requirement Levels [https://doi.org/10.17487/RFC2119](https://doi.org/10.17487/RFC2119) 


    [RFC3339] Date and Time on the Internet: Timestamps [https://doi.org/10.17487/RFC3339](https://doi.org/10.17487/RFC3339)


    [RFC4122] A Universally Unique IDentifier (UUID) URN Namespace  \
[https://doi.org/10.17487/rfc4122](https://doi.org/10.17487/rfc4122) 


    [RFC8174] Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words [https://doi.org/10.17487/RFC8174](https://doi.org/10.17487/RFC8174) 


    [RFC8493] The BagIt File Packaging Format (V1.0) \
[https://doi.org/10.17487/rfc8493](https://doi.org/10.17487/rfc8493) 


    [RO-Crate 1.1] RO-Crate Metadata Specification 1.1 \
[https://w3id.org/ro/crate/1.1](https://w3id.org/ro/crate/1.1) 


    [RO-Crate] Research Object Crate (RO-Crate) \
[https://w3id.org/ro/crate](https://w3id.org/ro/crate) 


    [schema] Schema.org vocabulary [https://schema.org/](https://schema.org/) 


    [schema Action] Schema.org potential action [https://schema.org/docs/actions.html](https://schema.org/docs/actions.html) 


    [Signposting] Signposting the Scholarly Web [https://signposting.org/](https://signposting.org/) 


    [Workflow RO-Crate] Workflow RO-Crate profile [https://w3id.org/workflowhub/workflow-ro-crate/1.0](https://w3id.org/workflowhub/workflow-ro-crate/1.0) 


    [Workflow Run Crate] Workflow Run Crate profile [https://w3id.org/ro/wfrun/workflow/0.1](https://w3id.org/ro/wfrun/workflow/0.1) 

[ZIP] APPNOTE.TXT - .ZIP File Format Specification 6.3.8 [http://www.pkware.com/documents/casestudies/APPNOTE.TXT](http://www.pkware.com/documents/casestudies/APPNOTE.TXT) 
