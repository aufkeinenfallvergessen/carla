### RoadRunner (Mathworks) Installation
==============================================================================================================================

Applying Licence
------------------------------------------------------------------------------------------------------------------------------
### Guide:  
https://de.mathworks.com/matlabcentral/answers/629828-why-i-can-t-find-the-download-link-for-roadrunner-on-the-download-page
### Contact Administrators:  
#### Eigener Account >> Lizenz >> Contact Administrator(s) >> Write an Mail to get the Licence	
https://de.mathworks.com/licensecenter/licenses/1107886/7691550/admin_contacts

Activate Licence on Specific PC
------------------------------------------------------------------------------------------------------------------------------
### Guide:
https://de.mathworks.com/help/roadrunner/ug/install-and-activate-roadrunner.html
### Procedure:
#### Eigener Account >> RoadRunner >> Install and Activate >> Activate A Computer
https://de.mathworks.com/licensecenter/licenses/1107886/7691550/products
```
ip addr | grep ether	# Get Host ID of Ethernet Interface
whoami			        # Get Computer Login Name
```
### Acitvation Label:
#### Eigener Account >> RoadRunner >> Install and Activate: Download Licence File (Arrow)
Device Name

Download and Installation RoadRunner
------------------------------------------------------------------------------------------------------------------------------
### Guide:
https://de.mathworks.com/help/roadrunner/ug/install-and-activate-roadrunner.html
### Download:
#### Eigener Account >> RoadRunner >> Manage Products: Download
### Installation:
Extract File
```
cd ~/Downloads
sudo dpkg -i RoadRunner_*.deb		# Follow all prompts to complete installation
```


Import Custom RoadRunner Map into Carla Package
==============================================================================================================================

Preparation for Building Custom Maps
------------------------------------------------------------------------------------------------------------------------------
### Make Directories
Has to be performed just once
```
cd ~/<Dir in Home>/carla/carla_sourceCode/RoadRunner_Maps
mkdir Input_forBuild
mkdir Output_fromBuild
sudo chmod 777 Input_forBuild           # Give Directory all Permissions
sudo chmod 777 Output_fromBuild         # Give Directory all Permissions
```

Build Custom Map in RoadRunner
------------------------------------------------------------------------------------------------------------------------------
### Guide:
https://de.mathworks.com/videos/search.html?q=&fq[]=product:RD&page=1

Add | Remove Custom Objects for Export in RoadRunner
------------------------------------------------------------------------------------------------------------------------------
### Guide:
https://de.mathworks.com/matlabcentral/answers/1594369-unsupported-filetype-selected-when-exporting-scenes-to-carla?s_tid=mlc_lp_leaf
### Procedure:
```
cd ~/<Dir in Home>/carla/carla_sourceCode/RoadRunner_Maps/<Project Name>/Project/
sudo geany OpenDriveAssetData.xml	    # Add Custom Objects (look in RoadRunner in "Library Browser" for the exact Paths and in "Attributes" for the Filenames)
```

Export Custom Map for Carla
------------------------------------------------------------------------------------------------------------------------------
### Guide:
https://carla.readthedocs.io/en/latest/tuto_M_generate_map/
### Procedure:
#### RoadRunner:  File >> Export >> Carla (.fbx, .xodr, rrdata.xml) >> File Path: <Map Name>.fbx
### Adjustments:
__Split by Segnentation:__  		    uncheck  
__Power of 2 Texture Dimensions:__      check  
__Embed Textures:__					    check  
__Export to Tiles:__				    check >> The Size: x, y: at least size of configured Map

Build Custom Map Package
------------------------------------------------------------------------------------------------------------------------------
### Guide:
https://carla.readthedocs.io/en/latest/tuto_M_add_map_package/
### Procedure:
```
cd ~/<Dir in Home>/carla/carla_sourceCode/RoadRunner_Maps/<Project Name>/Exports/
cp /* ~/<Dir in Home>/carla/carla_sourceCode/RoadRunner_Maps/Input_forBuild/
cd ~/<Dir in Home>/carla/carla_sourceCode/Util/Docker
python3 docker_tools.py --input ~/<Dir in Home>/carla/carla_sourceCode/RoadRunner_Maps/Input_forBuild/ --output ~/<Dir in Home>/carla/carla_sourceCode/RoadRunner_Maps/Output_fromBuild/ --packages map_package
```

Import Custom Map Package into Carla Package
------------------------------------------------------------------------------------------------------------------------------
### Guide:
https://carla.readthedocs.io/en/latest/tuto_M_add_map_package/
### Procedure:
```
cd ~/<Dir in Home>/carla/carla_sourceCode/RoadRunner_Maps/Output_fromBuild
sudo cp /* ~/<Dir in Home>/carla/carla_package/Import
cd ~/<Dir in Home>/carla/carla_package
./ImportAssets.sh
```

Run new Custom Map
------------------------------------------------------------------------------------------------------------------------------
### Guide:
https://carla.readthedocs.io/en/latest/tuto_M_add_map_package/
### Procedure:
#### Move into carla_package Interpreter
```
cd ~/<Dir in Home>/carla/carla_package
./CarlaUE4.sh						# Start CARLA in Console 1
cd PythonAPI/util					
python3 config.py --map <Map Name>	# Load Custom Map with Configuration in Console 2
cd ../examples
python3 manual_control.py 			# Launch a Vehicle in Manual Control in Custom Map in Console 2
```