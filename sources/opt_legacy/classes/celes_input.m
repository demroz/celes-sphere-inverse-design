%  Copyright (c) 2017, Amos Egel (KIT), Lorenzo Pattelli (LENS)
%                      Giacomo Mazzamuto (LENS)
%  All rights reserved.
%
%  Redistribution and use in source and binary forms, with or without
%  modification, are permitted provided that the following conditions are met:
%
%  * Redistributions of source code must retain the above copyright notice, this
%    list of conditions and the following disclaimer.
%
%  * Redistributions in binary form must reproduce the above copyright notice,
%    this list of conditions and the following disclaimer in the documentation
%    and/or other materials provided with the distribution.
%
%  * Neither the name of the copyright holder nor the names of its
%    contributors may be used to endorse or promote products derived from
%    this software without specific prior written permission.
%
%  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
%  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
%  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
%  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
%  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
%  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
%  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
%  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
%  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%  POSSIBILITY OF SUCH DAMAGE.

%> @file celes_input.m
% ======================================================================
%> @brief Parameters describing the model to be simulated, i.e., the particles and the excitation
% ======================================================================

classdef celes_input
    
    properties
        %> vacuum wavelength
        wavelength
        
        %> refractive index of the surrounding medium
        mediumRefractiveIndex
        
        %> celes_particles object which contains the parameters that 
        %> specify the particles sizes, positions and refractive indices
        particles
        
        %> celes_initialField object which contains the parameters that 
        %> specify the initial excitation (Gaussian beam)
        initialField
    end
    
    properties (Dependent)
        %> angular frequency (we use c=1)
        omega
        
        %> wavenumber in surrounding medium
        k_medium
        
        %> wavenumber inside particles
        k_particle
    end
    
    methods
        % ======================================================================
        %> @brief Get method for omega
        % ======================================================================
        function value=get.omega(obj)
            value = single(2*pi/obj.wavelength);
        end
        
        % ======================================================================
        %> @brief Get method for k_medium
        % ======================================================================
        function value=get.k_medium(obj)
            value = obj.omega*obj.mediumRefractiveIndex;
        end
        
        % ======================================================================
        %> @brief Get method for k_particle
        % ======================================================================
        function value=get.k_particle(obj)
            switch obj.particles.disperse
                case 'mono'
                    value = obj.omega*obj.particles.refractiveIndexArray;
                case 'poly'
                    value = obj.omega.*obj.particles.refractiveIndexArray;
                otherwise
                    error( 'action undefined' ) % to be implemented
            end
        end
        
        
    end
end

