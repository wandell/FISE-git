function rootPath=fiseRootPath()
% Return the path to the root iset directory
%
% This function must reside in the directory at the base of the FISE
% code directory structure.  It is used to determine the location of
% various sub-directories.
%
% Example:
%   fullfile(fiseRootPath,'data')

rootPath=which('fiseRootPath');

rootPath = fileparts(rootPath);

end
