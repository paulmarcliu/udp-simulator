
function variantPath
    % List the directories you want to make here
    M_SRC_DIR = 'm_src';
    C_SRC_DIR = 'c_src';
    SFUN_DIR  = 'sfun';
    MDL_DIR   = 'mdl';

    
    % List the files you want to move in a cell array here.
    M_FILES    = {'variantPath.m'};
    C_FILES    = {'float_uint.c', 'udp_tx_rx.c', 'uint_float.c'};
    SFUN_FILES = {'float_uint.mexw64', 'udp_tx_rx.mexw64', 'uint_float.mexw64'};
    MDL_FILES  = {'foo.mdl'   , 'bar.mdl'};
    
    % Ensure that all necessary directories exist
    makeDir(M_SRC_DIR);
    makeDir(C_SRC_DIR);
    makeDir(SFUN_DIR);
    makeDir(MDL_DIR);
    
    % Add the files to the appropriate folder
%    moveFilesToFolder(M_FILES   , M_SRC_DIR);
%    moveFilesToFolder(C_FILES   , C_SRC_DIR);
%    moveFilesToFolder(SFUN_FILES, SFUN_DIR);
%    moveFilesToFolder(MDL_FILES , MDL_DIR);
    
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
