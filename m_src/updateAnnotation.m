
% Update the annotation on the library blocks

function updateAnnotation()
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
    