% The MIT License (MIT)

Copyright (c) 2017 Paul Marc Liu (paul.marc.liu@gmail.com)
% 

Permission is hereby granted, free of charge, to any person obtaining a copy 
of this software and 
% associated documentation files (the "Software"), to deal
ing the Software without restriction, 
% including without limitation the rights
to use, copy, modify, merge, publish, distribute, 
% sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software 
% is 
furnished to do so, subject to the following conditions:


% The above copyright notice and this permission notice shall be included in
% 
all copies or substantial portions of the Software.


% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR

% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS 
% FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS 
% OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, 
% WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,

% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
% IN 
THE SOFTWARE.



function variantPath
    % List the directories you want to make here
    M_SRC_DIR = 'm_src';
    C_SRC_DIR = 'c_src';
    SFUN_DIR  = 'sfun';
    MDL_DIR   = 'mdl';

    
    % List the files you want to move in a cell array here.
    M_FILES    = {'utilities.m'};
    C_FILES    = {'float_uint.c', 'udp_tx_rx.c', 'uint_float.c'};
    SFUN_FILES = {'float_uint.mexw64', 'udp_tx_rx.mexw64', 'uint_float.mexw64'};
    MDL_FILES  = {'foo.mdl'   , 'bar.mdl'};
    
    % Ensure that all necessary directories exist
    makeDir(M_SRC_DIR);
    makeDir(C_SRC_DIR);
    makeDir(SFUN_DIR);
    makeDir(MDL_DIR);
    
    % Add the files to the appropriate folder
    moveFilesToFolder(M_FILES   , M_SRC_DIR);
    moveFilesToFolder(C_FILES   , C_SRC_DIR);
    moveFilesToFolder(SFUN_FILES, SFUN_DIR);
    moveFilesToFolder(MDL_FILES , MDL_DIR);
    
    % Add the new directories to the MATLAB Path
    addpath(M_SRC_DIR, C_SRC_DIR, SFUN_DIR, MDL_DIR);
    
    % Save the new MATLAB Path.
    %savepath;
end

% Check if DIRNAME exsists. If it does not, make a new directory named
% DIRNAME.
function makeDir(dirName)
    % Constants for checking if the directory already exists
    DIR = 'dir';
    IS_DIR = 7;

    if exist(dirName, DIR) ~= IS_DIR
        mkdir(dirName);
    end
end

% Move the files in FILENAMES to the destination folder.
function moveFilesToFolder(fileNames, dst)
    for idx = 1:length(fileNames)
        movefile(fileNames{idx}, dst);
    end
end

% Update the annotation on the library blocks

function updateAnnotation
    % get lib block path name from model block
    refBlk = get_param(gcb,'ReferenceBlock');
    % will be empty if it is a library block, otherwise model block
    if ~isempty(refBlk)
        % get lib name from lib (ref) block path
        lib = regexp(refBlk,'^(\w+)/','tokens');
        if ~isempty(lib)
            lib = char(lib{1});
            % check if lib is already in memory
            if bdIsLoaded(lib)
                % in memory so just read annotation
                annot = get_param(refBlk,'AttributesFormatString');
            else
                % not in memory, need to load first then read 
                load_system(lib);
                annot = get_param(refBlk,'AttributesFormatString');
                close_system(lib);
            end        
            % set model block annotation to library annotation
            set_param(gcb,'AttributesFormatString',annot);
        end
    end
end 
    